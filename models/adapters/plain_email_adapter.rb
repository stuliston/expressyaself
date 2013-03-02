module ExpressYaSelf
  module Adapters

    class PlainEmailAdapter

      def initialize(email)
        @email = email
      end

      def body
        email.body
      end

      def author_name
        email.from.first.name
      end

      def author_email
        "#{email.from.first.mailbox}@#{email.from.first.host}"
      end

      private

      attr_reader :email

    end
  end
end