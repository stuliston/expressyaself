require './models/tag_list'

module ExpressYaself
  module Adapters

    class EmailMessageAdapter

      def initialize(email)
        @email = email
      end

      def to_h
        {
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
        @boody ||= set_encoding relevant_email_part.body.to_s
      end

      def relevant_email_part
        email.message.parts.first || email
      end

      def set_encoding(str)
        str.force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '')
      end

      def author_name
        @author_name ||= from.name
      end

      def author_email
        @author_email ||= "#{from.mailbox}@#{from.host}"
      end

      def from
        @from ||= email.from.first
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