class Line < Sequel::Model
  many_to_one :story
  many_to_one :character

  def validate
    super
    validates_presence [:sequence, :story_id]
    validates_unique :sequence
  end

  def self.seq
    self.max(:sequence).to_f+1
  end
end
