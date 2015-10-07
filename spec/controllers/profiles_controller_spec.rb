require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

let!(:user)  {create(:user)}
let(:json_response)  {JSON.parse(response.body)}

before do
  sign_in(user)
end

context 'RESTful profile actions' do

  describe 'PUT #update' do

    it 'changes about me' do
      put :update,
        profile: attributes_for(:profile, about: 'new about', user_id: user.id)
      expect(json_response['about']).to eq('new about')
    end

    it 'changes availability' do
      put :update,
        user_id: user.id,
        profile: attributes_for(:profile, availability: 'Wed 8-10am', user_id: user.id)
      expect(json_response['availability']).to eq('Wed 8-10am')
    end

    it 'changes profile languages' do
      # binding.pry
      put :update,
            profile: attributes_for(:profile,
              profile_languages_attributes: [{
                language_id: 1,
                difficulty_id: 1
              }], user_id: user.id
            )
      expect(json_response['profile_languages'][0]['language_id']).to eq(1)
      expect(json_response['profile_languages'][0]['difficulty_id']).to eq(1)
    end

    it 'changes photo_id' do
      put :update,
        profile: attributes_for(:profile, photo_id: 20, user_id: user.id)
      expect(json_response['photo_id']).to eq(20)
    end

    xit 'does not change user_id' do
      put :update,
        profile: attributes_for(:profile, user_id: user.id)
      expect(user.profile.id).not_to eq(-25)
    end

    specify 'a user can only update own profile' do
      user2 = create(:user)
      put :update,
          profile: attributes_for(:profile, photo_id: 20, user_id: user2.id)
      expect(response.status).to eq(401)
    end

  end

  describe 'GET #show' do

    it 'sends back assosciated profile languages'

  end

end

end
