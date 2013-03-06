require 'mongoid'
require './models/adapters/email_message_adapter'

module ExpressYaSelf
  class Message
    include Mongoid::Document

    field :body,          type: String
    field :author_name,   type: String
    field :author_email,  type: String
    field :created_at,    type: DateTime
    field :tags,          type: Array

    def self.from_email(email)
      self.new(Adapters::EmailMessageAdapter.new(email).to_h)
    end

  end
end