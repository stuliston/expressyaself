module ExpressYaSelf

  class Tag

    def initialize(tag)
      @tag = tag
    end

    def to_s
      tag
    end

    def to_label
      to_s.gsub('#', '')
    end

    private

    def tag
      @tag.downcase.gsub(' ', '-').gsub('#', '')
    end

  end

end