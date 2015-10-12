require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create :user }
  before do
    sign_in(user)
    create(:membership, participant_type: 'owner')
  end

  context 'index' do
    before do
      get :index
    end

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
      expect(JSON.parse(response.body).first['owner']['email']).to include('myemail@user', '.com')
    end

    it 'should have language urls'

    it 'should work even if the user is not signed in' do
      sign_out(user)
      get :index
      expect(JSON.parse(response.body).first['title']).to eql('myProject')
    end
  end

  context 'show' do
    before do
      m = (create :membership, participant_type: 'owner')
      get :show, {id: m.project.id}
    end

    it 'should have a response' do
      expect(response.body).to_not be(nil)
    end

    it 'should have a project title' do
      expect(JSON.parse(response.body)['title']).to eql('myProject')
    end

    it 'should have a difficulty name' do
      expect(JSON.parse(response.body)['difficulty_name']).to eql('Beginner')
    end

    it 'should have a project_owner' do
      expect(JSON.parse(response.body)['owner']['email']).to include('myemail@user', '.com')
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

    it 'should redirect if there is no current_user' do
      sign_out(user)
      diff = create :difficulty
      params = {project: {title: 'myProject', difficulty_id: diff.id}}
      post :create, params
      expect(response.status).to eql(302)
    end

    it 'should return errors if the project is invalid' do
      diff = create :difficulty
      params = {project: { difficulty_id: diff.id }}
      post :create, params
      expect(JSON.parse(response.body)['errors']).to eql(['Title can\'t be blank'])
    end

    it 'should add new project languages' do
      diff = create :difficulty
      langs = []
      langs.push (create :language).name
      params = {project: { title: "myProj", difficulty_id: diff.id }, languages: langs}
      expect{post :create, params}.to change{ProjectLanguage.count}.by(1)
    end
  end
end
