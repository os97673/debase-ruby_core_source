# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem
require File.dirname(__FILE__) + "/lib/debase/ruby_core_source/version"

Gem::Specification.new do |s|
  s.name = "debase-ruby_core_source"
  s.version = Debase::RubyCoreSource::VERSION
  s.authors = ["Mark Moseley", "Gabriel Horner", "JetBrains RubyMine Team"]
  s.email = "os97673@gmail.com"
  s.homepage = "http://github.com/os97673/debugger-ruby_core_source"
  s.summary = %q{Provide Ruby core source files}
  s.description = %q{Provide Ruby core source files for C extensions that need them.}
  s.license = "MIT"
  s.required_rubygems_version = ">= 1.3.6"
  s.extra_rdoc_files = [ "README.md"]
  s.files = Dir["#{File.dirname(__FILE__)}/lib/**/*{.rb,inc,h}"] +
    Dir["#{File.dirname(__FILE__)}/{Rakefile,README.md,CHANGELOG.md,debase-ruby_core_source.gemspec}"]
  s.add_development_dependency "archive-tar-minitar", ">= 0.5.2"
  s.add_development_dependency 'rake', '~> 0.9.2'
end
