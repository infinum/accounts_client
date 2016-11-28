$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'infinum/accounts'
require 'webmock/rspec'
require 'pry'

Dir['./spec/support/**/*.rb'].each { |f| require f }
