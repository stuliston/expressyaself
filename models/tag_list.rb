module ExpressYaself

  class TagList < Array

    PATTERN = /(#[^#\s]+)/

    def self.from_subject_line(subject_line)
      self.new (subject_line || '').scan(PATTERN).flatten.collect(&:downcase).uniq
    end

  end

end