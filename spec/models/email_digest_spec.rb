require 'rails_helper'

RSpec.describe EmailDigest, type: :model do

  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  # let!(:owner_membership) { create(:membership, project: project, participant_type: 'owner') }
  let(:email_digest) {build(:email_digest, user_id: user.id)}

  context 'validations' do

    it 'should be valid with all fields filled' do
      expect(email_digest).to be_valid
    end

    it 'should not be valid without a user_id' do
      email_digest = build(:email_digest, user_id: nil)
      expect(email_digest).to_not be_valid
    end

    it 'should be valid if user_id is  unique' do
      email_digest2 = create(:email_digest, user_id: other_user.id)
      expect(email_digest).to be_valid
    end

    it 'should not be valid if user_id is not unique' do
      email_digest2 = create(:email_digest, user_id: user.id)
      expect(email_digest).to_not be_valid
    end

    it 'should not be valid without a day_delayed' do
      email_digest = build(:email_digest, days_delayed: nil)
      expect(email_digest).to_not be_valid
    end

    it 'should be valid if day_delayed is 1 or 7' do
      expect(email_digest).to be_valid
      email_digest2 = build(:email_digest, days_delayed: 7)
      expect(email_digest2).to be_valid
    end

    it 'should not be valid if day_delayed is not 1 or 7' do
      email_digest = build(:email_digest, days_delayed: 2)
      expect(email_digest).to_not be_valid
    end

  end

  context 'after_create #check_job_exists' do

    it "should create a daily/weekly Delayed Job if it doesn't exist yet" do
      expect{
        create(:email_digest)
      }.to change(Delayed::Job, :count).by(1)

    end

    it "should create a daily Delayed Job with correct attributes" do
      create(:email_digest)

      expect(Delayed::Job.first.queue).to eq('daily')
      expect(Delayed::Job.first.run_at).to be >= (Time.now)
      expect(Delayed::Job.first.run_at).to be <= (Time.now + 1.day).beginning_of_day
    end

    it "should create a weekly Delayed Job with correct attributes" do
      create(:email_digest, days_delayed: 7)

      expect(Delayed::Job.first.queue).to eq('weekly')
      expect(Delayed::Job.first.run_at).to be >= (Time.now)
      expect(Delayed::Job.first.run_at).to be <= (Time.now + 1.week).beginning_of_day
    end

    it "should not create a Delayed Job if it already exist" do
      email_digest2 = create(:email_digest, user_id: user.id)

      expect{
        create(:email_digest, user_id: other_user.id)
      }.to change(Delayed::Job, :count).by(0)
    end

    it "sends an email when Delayed Job is run" do
      Delayed::Worker.new.work_off
      expect(UserMailer).to receive(:mailboxer_msg)
      create(:email_digest, days_delayed: 1)
      Delayed::Job.first.update(run_at: Time.now)
      Delayed::Worker.new.work_off
    end

    it "should not send an email when Delayed Job run_at time has not yet passed" do
      Delayed::Worker.new.work_off
      expect(UserMailer).to_not receive(:mailboxer_msg)
      create(:email_digest, days_delayed: 1)
      Delayed::Job.first.update(run_at: Time.now+ 1.minute)
      Delayed::Worker.new.work_off
    end

  end

end
