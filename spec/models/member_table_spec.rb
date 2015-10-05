require 'rails_helper'

RSpec.describe MemberTable, type: :model do
  let(:table) { create :member_table }

  it 'should have a project' do
    expect(table.project).to be_a(Project)
  end

  it 'should have a user' do
    expect(table.user).to be_a(User)
  end
end
