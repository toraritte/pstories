class Line < Sequel::Model
  many_to_one :story
  many_to_one :character

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
