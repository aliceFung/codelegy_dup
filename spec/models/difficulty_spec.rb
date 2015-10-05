require 'rails_helper'

RSpec.describe Difficulty, type: :model do
  before do
    create :beginner
    create :medium
    create :expert
    create :master
  end

  it 'should have four difficulties' do
    expect(Difficulty.count).to eql(4)
  end
end
