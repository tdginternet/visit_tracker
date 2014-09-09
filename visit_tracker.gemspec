# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.

# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "visit_tracker/version"

Gem::Specification.new do |s|
  s.name    = "visit_tracker"
  s.summary = "Track visits"
  s.description = "Add a view counting in models."
  s.files   = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = VisitTracker::VERSION

  s.add_dependency 'googlecharts'

  s.add_development_dependency "sqlite3", "~> 1.3.5"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda"

  s.authors = ["TDG Internet"]
  s.email   = ["dev@tudogostoso.com.br"]
end
