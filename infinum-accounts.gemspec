lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infinum/accounts/version'

Gem::Specification.new do |spec|
  spec.name          = 'infinum-accounts'
  spec.version       = Infinum::Accounts::VERSION
  spec.authors       = ['Vrabac']
  spec.email         = ['vedran.hrncic@infinum.hr']

  spec.summary       = 'Infinum Accounts api client.'
  spec.description   = 'Infinum Accounts api client.'
  spec.homepage      = 'TODO: https://github.com/'

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'overcommit'
  spec.add_development_dependency 'bundler-audit'

  spec.add_dependency 'httparty'
end
