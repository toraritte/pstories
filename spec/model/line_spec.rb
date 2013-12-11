require 'spec_helper'

describe Line do
  it 'is valid with dialogue, character_id, story_id, sequence' do
    l = Line.new dialogue_item: 'ejha', character_id: 7, story_id: 5, sequence: Line.seq
    expect(l).to be_valid
  end

  it 'is valid with plot,                   story_id, sequence' do
    expect(Line.new plot_item: 'aaa', story_id: 2, sequence: Line.seq).to be_valid
  end

  it 'is invalid without sequence' do
    expect(Line.new plot_item: 'aaa', story_id: 7).not_to be_valid
  end

  it 'is invalid with duplicate sequence' do
    s = Story.create title: 'balabab'
    s.add_line plot_item: 'aab', sequence: 7.0
    l = Line.new plot_item: 'aaaaa', story_id: s.id, sequence: 7.0
    l.valid?
  # TODO - write an "errors_on" helper (see story_spec.rb)
  #        so this could be:
  # expect(l).to have(1).errors_on(:sequence)
    expect(l.errors).to have(1).on(:sequence)
  end

  it 'is invalid without story_id' do
    expect(Line.new plot_item: 'aaa', sequence: 1.0).not_to be_valid
  end

  it 'is invalid with dialogue, plot, character_id'
  it 'is invalid with dialogue, plot'
  it 'is invalid with           plot, character_id'
end
