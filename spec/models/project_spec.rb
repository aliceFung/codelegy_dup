require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'attributes' do
    let(:myProject) { create :project }

    it 'should be a have a title' do
      expect(myProject.title).to eql('myProject')
    end

    it 'must have a title' do
      no_title = Project.new
      expect{ no_title.save }.to change{ Project.count }.by(0)
    end

    it 'should be a have a availibility' do
      expect(myProject.availibility).to eql('weeknights')
    end

    it 'should be a have a description' do
      expect(myProject.description).to eql('really awesome!')
    end

    it 'should be a have a difficulty_id' do
      expect(myProject.difficulty).to be_a(Difficulty)
    end

    it 'should be a have a difficulty_name' do
      create :beginner
      expect(myProject.difficulty.name).to eql('Beginner')
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

  context 'Associations with Languages' do
    let(:table) { create :project_language }
    let(:language) { table.language }
    let(:myProject) { table.project }

    it 'should have languages' do
      expect(myProject.languages.count).to eql(1)
    end
  end
end
