require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before do
    create :membership
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
    expect(JSON.parse(response.body).first['owner']['email']).to include('myemail@user', ".com")
  end
end
