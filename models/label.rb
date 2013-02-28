class Label

  class << self

    def from_subject(subject)
      subject.split(' ').collect do |label|
        self.new(label)
      end
    end

  end

  def initialize(label)
    @label = label
  end

  def to_s
    label
  end

  private

  def label
    @label.downcase.gsub(' ', '-')
  end

end