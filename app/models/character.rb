class Character < Sequel::Model
  one_to_many :lines
  many_to_many :stories

  def validate
    super
    validates_presence :name
  end
end
