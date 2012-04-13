# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "gap"

Gem::Specification.new do |s|
  s.name        = "gap"
  s.version     = Gap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["yaguchi"]
  s.email       = ["yaguchi@galileoscope.com"]
  s.homepage    = %q{http://github.com/#{github_username}/#{project_name}}
  s.summary     = "god + cap"
  s.description = "gap is a wrapper of capistrano. gap = god + cap"

  #s.required_rubygems_version = ">= 1.3.6"
  #s.add_runtime_dependency("capistrano", ">= 2.9.0")
  #s.add_runtime_dependency("god", "~> 0.11.0")
  s.add_dependency(%q<capistrano>, [">= 2.9.0"])
  s.add_dependency(%q<god>, ["~> 0.11.0"])

  s.files        = Dir.glob("lib/**/*") + %w(README.rdoc Rakefile)
  s.require_path = 'lib'
end
