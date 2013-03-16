module ExpressYaself

  class TagList < Array

    PATTERN = /(#[^#\s]+)/

    def self.from_subject_line(subject_line)
      self.new (subject_line || '').scan(PATTERN).flatten.uniq.collect(&:downcase)
    end

  end

end