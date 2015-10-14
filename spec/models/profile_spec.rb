require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { create(:profile) }

  context 'associations' do
    it 'should respond to user' do
      expect(profile).to respond_to(:user)
    end

    it 'should respond to profile_languages' do
      expect(profile).to respond_to(:profile_languages)
    end

    specify 'profile_languages should be destroyed with profile' do
      profile.profile_languages.create(language_id: 1, difficulty_id: 1)
      expect{profile.destroy}.to change {ProfileLanguage.count}.by(-1)
    end
  end

  context 'validations' do
    it 'should not be valid without a user_id' do
      expect{Profile.create!(about: 'about me')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'email_frequency setting' do
    let(:user) { create(:user) }
    let(:profile) {create(:profile, email_frequency: 1, user_id: user.id)}
    let(:other_user) { create(:user) }

    it "should immediately send msg to user's inbox" do
      other_user.send_message(user, "Hello there!", "hi.")
      expect(user.mailbox.inbox.length).to eq(1)
    end

    #unsure how to test the mailboxer initiated config method
    xit "should create an EmailDigest when a msg is first sent" do
      expect{ other_user.send_message(user, "Hi!", "hi.")
              }.to change(EmailDigest, :count).by(9)
    end

  end

end
