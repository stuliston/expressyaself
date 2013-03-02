module ExpressYaSelf

  class EmailPresenter

    def initialize(email)
      @email = email
    end

    def body
      email.body || '[blank]'
    end

    def author_name
      email.author_name
    end

    def author_email
      email.author_email
    end

    def author_avatar
      hash = Digest::MD5::hexdigest author_email.strip.downcase
      "http://www.gravatar.com/avatar/#{hash}.jpg?s=40"
    end

    private

    attr_reader :email

  end

end