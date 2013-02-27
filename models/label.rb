class Label

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