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
            user_id: user.id,
            profile: attributes_for(:profile, about: 'new about')
      expect(json_response['about']).to eq('new about')
    end

    it 'changes availability' do
      put :update,
            user_id: user.id,
            profile: attributes_for(:profile, availability: 'Wed 8-10am')
      expect(json_response['availability']).to eq('Wed 8-10am')
    end

    it 'changes profile languages' do
      put :update,
            user_id: user.id,
            profile: attributes_for(:profile,
              profile_languages:
                attributes_for(:profile_languages,
                  language_id: 1,
                  difficulty_id: 1)
              )
      binding.pry
      expect(json_response['profile_languages']).to include({language_id: 1, difficulty_id: 1})
    end

    it 'changes photo_id' do
      put :update,
            user_id: user.id,
            profile: attributes_for(:profile, photo_id: 20)
      expect(json_response['photo_id']).to eq(20)
    end

    it 'does not change user_id' do
      put :update,
          user_id: user.id,
          profile: attributes_for(:profile, user_id: -25)
      expect(user.profile.id).not_to eq(-25)
    end

    specify 'a user can only update own profile' do
      # sign_in(user)
      user2 = create(:user)
      put :update,
          user_id: user2.id,
          profile: attributes_for(:profile, photo_id: 20)
      expect(response.status).to eq(401)
    end

  end

  describe 'GET #show' do

    it 'sends back assosciated profile languages'

  end

end

end
