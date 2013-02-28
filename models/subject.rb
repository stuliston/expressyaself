require_relative 'label'

module ExpressYaSelf

  class Subject

    def initialize(subject_line)
      @subject_line = subject_line
    end

    def to_tags
      @to_tags ||= (subject_line || '').scan(/(#[^#\s]+)/).flatten
    end

    private

    attr_reader :subject_line
  end

end