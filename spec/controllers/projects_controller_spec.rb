require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create :user }
  before do
    sign_in(user)
    create(:membership, participant_type: 'owner')
  end

  context 'index' do
    before { get :index }
    it 'should have a response' do
      expect(response.body).to_not be(nil)
    end

    it 'should have a project title' do
      expect(JSON.parse(response.body).first['title']).to eql('myProject')
    end

    it 'should have a difficulty name' do
      expect(JSON.parse(response.body).first['difficulty_name']).to eql('Beginner')
    end

    it 'should have a project_owner' do
      p JSON.parse(response.body)
      expect(JSON.parse(response.body).first['owner']['email']).to include('myemail@user', '.com')
    end
  end

  context 'create' do

    it 'should create a new project' do
      diff = create :difficulty
      params = {project: {title: 'myProject', difficulty_id: diff.id}}
      expect{post :create, params}.to change{Project.count}.by(1)
    end

    it 'should return a JSON object of the created project' do
      diff = create :difficulty
      params = {project: {title: 'myProject', difficulty_id: diff.id}}
      post :create, params
      expect(JSON.parse(response.body)['title']).to eql('myProject')
      expect(JSON.parse(response.body)['difficulty_name']).to eql('Beginner')

    end
  end
end
