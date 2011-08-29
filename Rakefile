# encoding: utf-8
require 'rubygems'
require 'rake'
require './lib/logme/version'

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "log-me"
  gem.homepage = "http://github.com/prodis/log-me"
  gem.license = "MIT"
  gem.summary = %Q{A simple way to configure log in your gem.}
  gem.description = %Q{LogMe is a simple way to configure log in your gem. It's especially useful when you need to log Web Service calls or HTTP requests and responses.}
  gem.email = "prodis@gmail.com"
  gem.authors = ["Prodis a.k.a. Fernando Hamasaki"]
  gem.version = LogMe::Version::VERSION
  gem.required_ruby_version = ">= 1.8.7"
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "log-me #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
