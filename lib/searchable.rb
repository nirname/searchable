require 'elasticsearch/model'

Kaminari::Hooks.init
Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari

module Searchable

  extend ActiveSupport::Concern

  mattr_accessor :settings
  mattr_accessor :indexes

  def self.default_settings
    {
      analysis: {
        analyzer: {
          ngram_analyzer: {
            type: "custom",
            tokenizer: "keyword",
            filter: ["lowercase", "ngram_filter"]
          },
          keyword_analyzer: {
            type: "custom",
            tokenizer: "keyword",
            filter: ["lowercase"]
          }
        },
        filter: {
          ngram_filter: {
            type: "nGram",
            min_gram: 1,
            max_gram: 100
          }
        }
      }
    }
  end

  def self.default_mapping
    {
      type: "string",
      index_analyzer: "ngram_analyzer",
      search_analyzer: "keyword_analyzer"
    }
  end

  def self.default_indexes
    {}
  end

  self.settings = self.default_settings
  self.indexes = self.default_indexes

  def self.setup
    begin
      yield self
    rescue => exception
      puts "Searchable: error: #{ exception }"
    end
    self.settings ||= self.default_settings
    self.indexes ||= self.default_indexes
  end

  def self.mapping(klass, &block)
    self.indexes[klass] = yield
  end

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    klass = self
    model_key = klass.model_name.underscore.to_sym

    settings Searchable.settings do
      mappings do
        Array.wrap(Searchable.indexes[model_key]).each do |method_name|
          indexes method_name, Searchable.default_mapping
        end
      end
    end

  end

end
