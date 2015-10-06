require 'rails_helper'

include Devise::TestHelpers

describe Users::SessionsController do

  # let!(:user) { create(:user) }
  # let(:json) { JSON.parse(response.body) }

  # context 'RESTful actions' do

  #   describe 'POST #create' do

  #     specify 'create a session on sign in' do
  #       # request.env["devise.mapping"] = Devise.mappings[:user]
  #       # # binding.pry
  #       # post :create#, user: :user, format: :json
  #       sign_in :user, user

  #       binding.pry
  #       expect(json.username).to eq(user.username)
  #       expect(json.email).to eq(user.email)
  #       expect(json.provider).to eq(user.provider)
  #       expect(json.uid).to eq(user.uid)
  #     end

  #   end

    # describe 'DELETE #destroy' do

    #   specify 'destroy a session on sign out'

    # end

  # end

end
