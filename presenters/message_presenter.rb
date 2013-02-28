module ExpressYaSelf

  class MessagePresenter

    def initialize(message)
      @message = message
    end

    def body
      message.body
    end

    def author_name
      message.author_name
    end

    def author_email
      message.author_email
    end

    private

    attr_reader :message

  end

end