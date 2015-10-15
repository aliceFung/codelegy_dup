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
      expect{ user2 = create(:user) }.to change {Profile.count}.by(1)
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
                      sender_username: Mailboxer::Message.last.sender.username,
                      id: Mailboxer::Message.last.id}
      msg = other_user.get_emails('inbox')[0]
      expect(other_user.get_emails('inbox')).to eq([mock_message])
    end

  end

  context 'project' do

    let!(:project){create :project}
    let!(:owner_membership){create :membership,
                                user_id: user.id,
                                project_id: project.id,
                                participant_type: 'owner'}
    let!(:membership){create :membership,
                                user_id: other_user.id,
                                project_id: project.id,
                                participant_type: 'member'}

    let!(:project_w_pending_member){create :project}
    let!(:owner_membership2){create :membership,
                            user_id: other_user.id,
                            project_id: project_w_pending_member.id,
                                participant_type: 'owner'}
    let!(:pending_membership){create :membership,
                            user_id: user.id,
                            project_id: project_w_pending_member.id}

    let!(:project_w_rejected_member){create :project}
    let!(:owner_membership3){create :membership,
                            user_id: other_user.id,
                            project_id: project_w_rejected_member.id,
                            participant_type: 'owner'}
    let!(:rejected_membership){create :membership,
                          user_id: user.id,
                          project_id: project_w_rejected_member.id,
                          participant_type: 'rejected'}

    let!(:project_wo_member){create :project}


    it 'should return projects user has membership with pending, member, or owner status' do
      expect(user.project_dashboard_membership.length).to eq(2)
    end

    it 'should return limited member detail information to owner' do
      result = user.project_dashboard_membership
      idx = 0
      result.each_with_index do |proj, index|
        return idx = index if project.id == proj['id']
      end

      exp_membership_info = [ { :id => owner_membership.id,
                              :user => user.username,
                  :participant_type => "owner"},
                              {:id => membership.id,
                            :user => other_user.username,
                :participant_type => "member"} ]


      expect(result[idx][:owner?]).to be_truthy
      expect(result[idx][:memberships].length).to eq(2)
      expect(result[idx][:memberships]).to eq(exp_membership_info)
    end

    it 'should not have membership information to rejected memberships' do
      result = other_user.project_dashboard_membership
      idx = 0
      result.each_with_index do |proj, index|
        return idx = index if project_w_rejected_member.id == proj['id']
      end
      expect(result[idx][:owner?]).to be_falsy
      expect(result[idx][:memberships]).to eq(nil)
    end

    it 'should not have membership information to pending memberships' do
      result = other_user.project_dashboard_membership
      idx = 0
      result.each_with_index do |proj, index|
        return idx = index if project_w_pending_member.id == proj['id']
      end
      expect(result[idx][:owner?]).to be_falsy
      expect(result[idx][:memberships]).to eq(nil)
    end

    it 'should not have membership information to members' do
      result = other_user.project_dashboard_membership
      idx = 0
      result.each_with_index do |proj, index|
        return idx = index if project.id == proj['id']
      end
      expect(result[idx][:owner?]).to be_falsy
      expect(result[idx][:memberships]).to eq(nil)
    end

    ## unused instance methods
    # it 'should return projects user has active membership in'
    # it 'should not return projects user has inactive membership (pending, rejected) in'
    # it 'should return projects without membership information to non-owner'

  end

end
