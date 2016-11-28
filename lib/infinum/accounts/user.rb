module Infinum
  module Accounts
    class User # :nodoc:
      CHECK_CREDENTIALS = '/api/users/check_credentials'.freeze

      attr_reader :id
      attr_reader :email
      attr_reader :first_name
      attr_reader :last_name

      def initialize(data)
        @id = data.fetch('id')
        @email = data.fetch('email')
        @first_name = data.fetch('first_name')
        @last_name = data.fetch('last_name')
      end

      def self.deserialize(response)
        new(response['user'])
      end

      def self.check_credentials(username, password, **args)
        http = { path: CHECK_CREDENTIALS, verb: :post,
                 body: { username: username, password: password } }
        Request.new(self, http.merge(**args)).resource
      end
    end
  end
end
