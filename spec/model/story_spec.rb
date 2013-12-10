require 'spec_helper'

describe Story do

  it "is valid with a title" do
    story = Story.new title: 'balabab'
    expect(story).to be_valid
  end

  it "is invalid without a title" do
    expect(Story.new title: nil).to have(1).errors_on(:title)
  end
end
