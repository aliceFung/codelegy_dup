require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:sender_email) { "no-reply@codelegy.xyz" }

  before :each do
    @project = create(:project)
    @owner = create(:user)
    @project.members.push(@owner)
    @project.memberships[0].update(participant_type: 'owner')
  end

  describe 'send_request_email' do
    it 'should send an email' do
      expect{
        UserMailer.request_membership(@owner, @project).deliver_now
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    describe 'mail properties' do
      let(:requester) { build(:user) }
      let(:mail) { UserMailer.request_membership(requester, @project) }

      it 'should send the email to the project owner' do
        expect(mail.to).to eq([@owner.email])
      end

      it 'should use the proper sender email' do
        expect(mail.from).to eq([sender_email])
      end

      it 'should send the email with the proper subject' do
        expect(mail.subject).to eq("#{requester.email} wants to join #{@project.title}")
      end
    end
  end
end
