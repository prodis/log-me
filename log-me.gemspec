lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logme/version'

Gem::Specification.new do |gem|
  gem.name        = "log-me"
  gem.version     = LogMe::VERSION
  gem.authors     = ["Prodis a.k.a. Fernando Hamasaki de Amorim"]
  gem.email       = ["prodis@gmail.com"]
  gem.summary     = "A simple way to configure log in your gem."
  gem.description = "LogMe is a simple way to configure log in your gem. It's especially useful when you need to log Web Service calls or HTTP requests and responses."
  gem.homepage    = "http://github.com/prodis/log-me"
  gem.licenses    = ["MIT"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.platform              = Gem::Platform::RUBY
  gem.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  gem.add_development_dependency "coveralls"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.14"
end
