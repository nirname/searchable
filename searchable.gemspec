Gem::Specification.new do |s|
  s.name        = 'searchable'
  s.version     = '0.0.1'
  s.date        = '2014-04-11'
  s.summary     = "Searchable"
  s.description = "Searchable module for elasticsearch-rails gem"
  s.authors     = ["Nikolay Rozhkov"]
  s.email       = 'nrozhkov@at-consulting.ru'
  s.files       = ["lib/searchable.rb"]
  s.files       = Dir["{app,config,db,lib}/**/*", "README.md"]
  s.homepage    = 'http://github.com/nirname/searchable'
  s.license     = 'MIT'

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "elasticsearch-model"
  s.add_dependency "elasticsearch-rails"

end
