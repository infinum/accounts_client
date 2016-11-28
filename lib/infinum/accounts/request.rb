require 'json'

module Infinum
  module Accounts
    class Request # :nodoc:
      Error = Class.new(StandardError)
      Unauthorized = Class.new(Error)
      Forbidden = Class.new(Error)

      attr_reader :model
      attr_reader :body
      attr_reader :headers
      attr_reader :path
      attr_reader :query
      attr_reader :verb

      def initialize(model, opts = {})
        @model = model
        @body = opts.fetch(:body, nil)
        @headers = opts.fetch(:headers, {})
        @path = opts.fetch(:path)
        @query = opts.fetch(:query, {})
        @verb = opts.fetch(:verb)
      end

      def resource
        deserialize(perform)
      end

      private

      def deserialize(data)
        model.deserialize(data)
      end

      def perform
        response = HTTParty.send(verb, uri, query: q, headers: h, body: b)

        return response if success?(response)
        failure!(response)
      end

      def q
        { app_id: Accounts.config.app_id }.merge(query)
      end

      def h
        { 'Content-Type' => 'application/json',
          'Accept' => 'application/json' }.merge(headers)
      end

      def b
        JSON.dump(body) if body
      end

      def uri
        Accounts.config.url + path
      end

      def success?(response)
        (200...300).cover?(response.code)
      end

      def failure!(response)
        raise(Unauthorized, 'Unrecognized app') if response.code == 401
        raise raise Forbidden, 'Invalid credentials' if response.code == 403
        raise Error, 'Invalid request'
      end
    end
  end
end
