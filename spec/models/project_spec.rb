require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'attributes' do
    let(:myProject) { create :project }

    it 'should be a have a title' do
      expect(myProject.title).to eql('myProject')
    end

    it 'should be a have a availibility' do
      expect(myProject.availibility).to eql('weeknights')
    end

    it 'should be a have a description' do
      expect(myProject.description).to eql('really awesome!')
    end

    it 'should be a have a difficulty_id' do
      expect(myProject.difficulty_id).to eql(3)
    end
  end

  context 'Associations with Users' do
    let(:table) { create :member_table }
    let(:owner) { table.user }
    let(:myProject) { table.project }

    it 'should have users' do
      expect(myProject.users.count).to eql(1)
    end
  end
end
