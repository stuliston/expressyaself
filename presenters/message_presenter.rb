module ExpressYaself

  class MessagePresenter

    def initialize(message)
      @message = message
    end

    def body
      (message.body || '[blank]').gsub("\n", '<br/>')
    end

    def author_name
      message.author_name
    end

    def author_email
      message.author_email
    end

    def author_avatar
      hash = Digest::MD5::hexdigest author_email.strip.downcase
      "http://www.gravatar.com/avatar/#{hash}.jpg?s=50"
    end

    def html_for_message
      @engine ||= Haml::Engine.new(File.open('views/message.haml').read)
      @engine.render(Object.new, message: self)
    end

    private

    attr_reader :message

  end

end
