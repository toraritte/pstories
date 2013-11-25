class Line < Sequel::Model
  many_to_one :story
  many_to_one :character
end
