require 'spec_helper'

describe Character do

  it 'is valid with a name' do
    c = Character.new name: 'p'
    expect(c).to be_valid
  end

  it 'is invalid without a name' do
    expect(Character.new name: nil).not_to be_valid
  end

  # 1st: how to implement it in rspec?
  it 'is valid with duplicate names'  do
    Character.create name: 'p'
    expect(Character.create name: 'p').to be_valid
  end
  # see story_spec.rb for the errors issue
end
