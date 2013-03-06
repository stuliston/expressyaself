module ExpressYaSelf

  class MessagePresenter

    def initialize(message)
      @message = message
    end

    def body
      message.body || '[blank]'
    end

    def author_name
      message.author_name
    end

    def author_email
      message.author_email
    end

    def author_avatar
      hash = Digest::MD5::hexdigest author_email.strip.downcase
      "http://www.gravatar.com/avatar/#{hash}.jpg?s=40"
    end

    private

    attr_reader :message

  end

end