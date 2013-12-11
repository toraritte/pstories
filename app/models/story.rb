# TODO[9] - DB mess, see "git log --format=%B -n 1 c3c3086"
# A couple examples:
#   * STORY[:id].add_character -> merrily saves duplicates
#   * CHARACTER also saves duplicates with "create"
#     ("find_or_create" is ok)
#   * LINE needs to be modified (?) or use special story character ('')
#     to distinguish plot and dialogue items

# SOLUTION?
#   * validations?
#   * nothing else comes into mind...

class Story < Sequel::Model
  one_to_many :lines
  many_to_many :characters

  def validate
    super
    validates_presence [:title]
    validates_unique :title
  end
end
