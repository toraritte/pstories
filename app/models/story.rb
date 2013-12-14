# TODO[9] - DB mess, see "git log --format=%B -n 1 c3c3086"
# TODO[9] - couple examples: STORY[:id].add_character -> merrily saves duplicates
# TODO[9] - UPDATE: this is intentional. use story.title (or .id) as a namespace

class Story < Sequel::Model
  one_to_many :lines
  many_to_many :characters

  def validate
    super
    validates_presence [:title]
    validates_unique :title
  end
end
