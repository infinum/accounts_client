require 'httparty'
require 'infinum/accounts/client'
require 'infinum/accounts/request'
require 'infinum/accounts/user'
require 'infinum/accounts/version'

module Infinum
  module Accounts # :nodoc:
    def self.config
      @config ||= Config.new
    end

    def self.setup
      yield config if block_given?
    end

    def self.client
      @client ||= Client.new
    end

    class Config # :nodoc:
      attr_accessor :url
      attr_accessor :app_id
    end
  end
end
