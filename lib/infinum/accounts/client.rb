module Infinum
  module Accounts
    class Client # :nodoc:
      def check_credentials(*args)
        User.check_credentials(*args)
      end
    end
  end
end
