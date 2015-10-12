require 'rails_helper'

RSpec.describe Membership, type: :model do

  let!(:project) { create(:project) }
  let!(:owner_membership) { create(:membership, project: project, participant_type: 'owner') }

  it 'should create a membership with pending status' do
    membership1 = create(:membership, project: project)
    expect(membership1.participant_type).to eq('pending')
  end

  it 'should not create membership if already exists' do
    membership1 = create(:membership, project: project)
    membership2 = build(:membership, user: membership1.user, project: membership1.project)
    expect(membership2).to_not be_valid
  end

  it 'should create valid membership' do
    expect(build(:membership)).to be_valid
  end

  it 'should not create if not valid (missing project)' do
    membership1 = build(:membership, project: nil)
    expect(membership1).to_not be_valid
  end

  it 'should not create if not valid (missing user)' do
    membership1 = build(:membership, user: nil)
    expect(membership1).to_not be_valid
  end

  it 'should create delayed job email if membership requested' do
    expect{
      create(:membership, project: project)
    }.to change(Delayed::Job, :count).by(1)
  end

  it 'should not create delayed job email if owner membership generated' do
    expect{
      create(:membership, project: project, participant_type: 'owner')
    }.to change(Delayed::Job, :count).by(0)
  end

  it "sends creates a delayed job email after creation" do
    expect { create(:membership, project: project) }.to change(Delayed::Job, :count).by(1)
  end

  it "sends an email after creation" do
    Delayed::Worker.new.work_off
    expect(UserMailer).to receive(:request_membership)
    project = create(:project)
    new_member = create(:user)
    create(:membership, user: new_member, project: project, participant_type: 'pending')
    Delayed::Worker.new.work_off
  end
end
