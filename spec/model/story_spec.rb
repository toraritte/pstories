require 'spec_helper'

describe Story do

  it "is valid with a title" do
    story = Story.new title: 'abc'
    expect(story).to be_valid
  end

  it "is invalid without a title" do
    expect(Story.new title: nil).not_to be_valid
  end

  # sequel errors hash is empty until valid? is called
  it "will produce an error on creation" do
    story = Story.new title: nil
    story.valid?
    expect(story.errors).to have(1).on :title
  # expect(story).to have(1).errors -> works too but not that explicit
  end

  it 'is invalid with duplicate title'
end
