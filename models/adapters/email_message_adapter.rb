require './models/tag_list'

module ExpressYaSelf
  module Adapters

    class EmailMessageAdapter

      def initialize(email)
        @email = email
      end

      def to_h
        @to_h ||= {
          body:         body,
          author_name:  author_name,
          author_email: author_email,
          tags:         tags,
          sent_at:      sent_at
        }
      end

      private

      attr_reader :email

      def body
        @boody ||= (email.message.parts.first || email).body.to_s
      end

      def author_name
        @author_name ||= email.from.first.name
      end

      def author_email
        @author_email ||= "#{email.from.first.mailbox}@#{email.from.first.host}"
      end

      def tags
        @tags ||= TagList.from_subject_line(email.subject)
      end

      def sent_at
        @sent_at ||= email.message.date
      end

    end
  end
end