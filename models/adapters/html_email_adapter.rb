module ExpressYaSelf
  module Adapters

    class HtmlEmailAdapter

      def initialize(email)
        @email = email
      end

      def body
        email.parts.first.body
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