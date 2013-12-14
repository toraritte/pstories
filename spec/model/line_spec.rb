require 'spec_helper'

describe Line do
  it 'is valid with line_item, story_id, sequence' do
    l = Line.new line_item: 'ejha', story_id: 5, sequence: Line.seq
    expect(l).to be_valid
  end

  it 'is invalid without sequence' do
    expect(Line.new line_item: 'aaa', story_id: 7).not_to be_valid
  end

  it 'is invalid with duplicate sequence' do
    s = Story.create title: 'balabab'
    s.add_line line_item: 'aab', sequence: 7.0
    l = Line.new line_item: 'aaaaa', story_id: s.id, sequence: 7.0
    l.valid?
  # TODO - write an "errors_on" helper (see story_spec.rb)
  # TODO -       so this could be:
  # TODO - expect(l).to have(1).errors_on(:sequence)
    expect(l.errors).to have(1).on(:sequence)
  end

  it 'is invalid without story_id' do
    expect(Line.new line_item: 'aaa', sequence: 1.0).not_to be_valid
  end

  it 'is invalid without or empty line_item' do
    expect(Line.new sequence: 7.0, story_id: 1).not_to be_valid
  end
end
