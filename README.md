# The Visit Tracker GEM

This GEM count and store visits on object and you can choose to create custom histories of access.

## Install

1. Put this line in your Gemfile:
```ruby
gem 'visit_tracker', git: "https://github.com/tdginternet/VisitTracker.git"
```
2. Then bundle:
```sh
$ bundle
```
3. Then generate and run the migrations
```sh
$ rails g visit_tracker:install
$ rake db:migrate
```

The GEM is ready to use.

#TODO: Docs about how to use