require 'delegate'
require 'singleton'

module ExpressYaSelf

  class GmailClient < SimpleDelegator

    include Singleton

    def initialize
      client = Gmail.connect('xxpressyaself@gmail.com', 'pencilgoblin')
      super(client)
    end

  end

end