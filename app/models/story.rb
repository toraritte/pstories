class Story < Sequel::Model
  one_to_many :lines
  many_to_many :characters
end
