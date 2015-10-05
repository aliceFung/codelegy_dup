require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'project membership request' do
    let(:user) {create(:user)}
    let(:project){create(:project)}
    let(:mail) { UserMailer.request_membership(user, project.id) }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{user.email} wants to join #{project.title}")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(user.email)
    end

    it 'renders the sender email' do
      expect(mail.from).to eq('no-reply@codelegy.xyz')
    end

  end
end
