require 'rails_helper'

RSpec.describe Membership, type: :model do
  it 'should not create membership if already exists' do
    membership1 = create(:membership)
    membership2 = build(:membership, user: membership1.user, project: membership1.project)
    expect(membership2).to_not be_valid
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
      create(:membership)
    }.to change(Delayed::Job, :count).by(1)
  end

  xit "sends an email" do
    expect { create(:membership) }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
