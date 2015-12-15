lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logme/version'

Gem::Specification.new do |spec|
  spec.name        = 'log-me'
  spec.version     = LogMe::VERSION
  spec.authors     = ['Prodis a.k.a. Fernando Hamasaki de Amorim']
  spec.email       = ['prodis@gmail.com']
  spec.summary     = 'A simple way to configure log in your spec.'
  spec.description = 'LogMe is a simple way to configure log in your spec. It is especially useful when you need to log Web Service calls or HTTP requests and responses.'
  spec.homepage    = 'http://github.com/prodis/log-me'
  spec.licenses    = ['MIT']

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.platform = Gem::Platform::RUBY

  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10'
  spec.add_development_dependency 'rspec', '~> 3.4'
end
