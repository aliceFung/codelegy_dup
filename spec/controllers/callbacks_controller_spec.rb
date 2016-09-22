require 'rails_helper'

describe Users::CallbacksController do

  let!(:user) { create(:user) }
  let(:json) { JSON.parse(response.body) }
  before do
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new( 
      provider: user.provider,
      uid: user.uid,
      info: {email: user.email}
    )
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context 'github' do

    describe 'sign in' do
      it 'should not allow invalid credentials' do
        get 'github', format: :json

        expect(json['email']).to eq(user.email)
        expect(json['provider']).to eq(user.provider)
        expect(json['uid']).to eq(user.uid)
      end
    end
    
  end

end
