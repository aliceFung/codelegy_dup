require 'rails_helper'

RSpec.describe User, type: :model do


  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }

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

    it 'should respond to mailbox' do
      expect(user).to respond_to(:mailbox)
    end

    specify 'profile should be destroyed with user' do
      expect{user.destroy}.to change {Profile.count}.by(-1)
    end

    specify 'creating a user creates a new profile' do
      user2 = build(:user)
      expect{user2.save}.to change {Profile.count}.by(1)
    end

  end

  context 'messages' do
    it "should fill up other user's inbox" do
      user.send_message(other_user, "Hello there!", "hi.")
      user.send_message(other_user, "Hello there!", "hi.")
      user.send_message(other_user, "Hello there!", "hi.")

      expect(other_user.mailbox.inbox.length).to eq(3)
    end

    it "should let a user get list of inbox messages" do
      user.send_message(other_user, "Hello there!", "hi.")
      user.send_message(other_user, "Hello there!", "hi.")
      user.send_message(other_user, "Hello there!", "hi.")

      expect(other_user.get_emails('inbox').length).to eq(3)
    end

    it "should get inbox messages in proper format" do
      user.send_message(other_user, "Hi there!", "Test.")
      mock_message = {date: Mailboxer::Message.last.created_at,
                      body: Mailboxer::Message.last.body,
                      subject: Mailboxer::Message.last.subject,
                      sender_username: Mailboxer::Message.last.sender.username}
      msg = other_user.get_emails('inbox')[0]
      # expect(other_user.get_emails('inbox')).to eq([mock_message])
      expect(msg[:date]).to eq(mock_message[:date])
      expect(msg[:body]).to eq(mock_message[:body])
      expect(msg[:subject]).to eq(mock_message[:subject])
      expect(msg[:sender_username]).to eq(mock_message[:sender_username])
    end
  end

end
