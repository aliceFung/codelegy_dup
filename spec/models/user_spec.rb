require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(profile) { create(:profile) }

  context 'associations' do
    it 'should respond to profile' do
      expect(user).to respond_to(:profile)
    end

    it 'should respond to memberships' do
      expect(user).to respond_to(:memberships)
    end

    it 'should respond to projects' do
      expect(user).to respond_to(:projects)
    end

    it 'should respond to sent_emails' do
      expect(user).to respond_to(:sent_emails)
    end

    specify 'profile should be destroyed with user' do
      
      expect{user.destroy}.to change {Profile.count}.by(-1)
    end
  end
end
