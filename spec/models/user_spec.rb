require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  context 'messages' do
    it "should fill up other user's inbox" do
      user.send_message(other_user, "Hello there!", "hi.")
      user.send_message(other_user, "Hello there!", "hi.")
      user.send_message(other_user, "Hello there!", "hi.")

      expect(other_user.mailbox.inbox.length).to eq(3)
    end
  end
end
