Searchable
==========

This project rocks and uses MIT-LICENSE.

It contains searchable module for elasticsearch-model gem. Being included in a model adds mapping to it according to config file, which is separate of the model.

Inspired by https://github.com/at-consulting/elastic_meta_search.

Installation
------------

Write in your Gemfile:

```ruby
gem "searchable", github: "nirname/searchable"
```

Using
-----

Just write inside `YourModel`:

```ruby
include Searchable
```

To check whether it works try:
```ruby
YourModel.mappings
```
