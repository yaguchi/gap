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
  s.description = ""

  #s.required_rubygems_version = ">= 1.3.6"
  #s.add_dependency("rails", ">= 3.0.10")
  #s.add_dependency('rack',  '~> 1.3.2')

  s.files        = Dir.glob("lib/**/*") + %w(README.rdoc Rakefile)
  s.require_path = 'lib'
end
