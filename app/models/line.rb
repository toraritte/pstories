class Line < Sequel::Model
  many_to_one :story
  many_to_one :character

  # TODO[5] - validation for line creation
  # TODO[5] -   new dialogue? character needed (new or existing char?)

  def self.seq
    Line.max(:sequence)+1
  end

  def plot?
    self.plot_item ? true : false
  end

  def plot
    self.plot? ? :plot_item : :dialogue_item
  end
end
