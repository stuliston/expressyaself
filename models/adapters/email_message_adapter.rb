module ExpressYaSelf
  module Adapters

    class EmailMessageAdapter

      def initialize(message)
        @message = message
      end

      def to_h
        {
          body:         body,
          author_name:  author_name,
          author_email: author_email,
          tags:         tags
        }
      end

      private

      attr_reader :message

      def body
        message.body rescue message.parts.first
      end

      def author_name
        message.from.first.name
      end

      def author_email
        "#{message.from.first.mailbox}@#{message.from.first.host}"
      end

      def tags
        @tags ||= TagList.from_subject_line(message.subject)
      end

    end
  end
end