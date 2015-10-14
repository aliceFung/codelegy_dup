require 'rails_helper'

RSpec.describe DayTimeslot, type: :model do
  let!(:day_timeslot) { create(:profile_timeslot) }

  context 'Accociation' do
    it 'should respond to day method' do
      expect(day_timeslot).to respond_to(:day)
    end

    it 'should respond to timeslot method' do
      expect(day_timeslot).to respond_to(:timeslot)
    end

    it 'should respond to owner method' do
      expect(day_timeslot).to respond_to(:owner)
    end
  end

  context 'Validation' do
    it 'should raise error when create a new day_timeslot with identical (day, timeslot, owner) combination' do
      new_day_timeslot = build(:profile_timeslot)
      new_day_timeslot.day_id = day_timeslot.day_id
      new_day_timeslot.timeslot_id = day_timeslot.timeslot_id
      new_day_timeslot.owner_id = day_timeslot.owner_id
      new_day_timeslot.owner_type = day_timeslot.owner_type

      expect{new_day_timeslot.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not raise error when create a new day_timeslot with identical (day, timeslot) combination' do
      new_day_timeslot = build(:profile_timeslot)
      new_day_timeslot.day_id = day_timeslot.day_id
      new_day_timeslot.timeslot_id = day_timeslot.timeslot_id

      expect{new_day_timeslot.save!}.not_to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should raise error if day_id is missing' do
      new_day_timeslot = build(:profile_timeslot)
      new_day_timeslot.day_id = nil
      expect{new_day_timeslot.save}.to change{DayTimeslot.count}.by(0)
      expect{new_day_timeslot.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should raise error if timeslot_id is missing' do
      new_day_timeslot = build(:profile_timeslot)
      new_day_timeslot.timeslot_id = nil
      expect{new_day_timeslot.save}.to change{DayTimeslot.count}.by(0)
      expect{new_day_timeslot.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should raise error if owner_id is missing' do
      new_day_timeslot = build(:profile_timeslot)
      new_day_timeslot.owner_id = nil
      expect{new_day_timeslot.save}.to change{DayTimeslot.count}.by(0)
      expect{new_day_timeslot.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should raise error if owner_type is missing' do
      new_day_timeslot = build(:profile_timeslot)
      new_day_timeslot.owner_type = nil
      expect{new_day_timeslot.save}.to change{DayTimeslot.count}.by(0)
      expect{new_day_timeslot.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should save if all field are present' do
      new_day_timeslot = build(:profile_timeslot)

      expect{new_day_timeslot.save}.to change{DayTimeslot.count}.by(1)
      expect{new_day_timeslot.save!}.not_to raise_error(ActiveRecord::RecordInvalid)
    end

  end

  context 'polymorphism' do
    it 'should be valid with a owner of profile' do
      profile_timeslot = build(:profile_timeslot)
      expect(profile_timeslot).to be_valid
    end

    it 'should be valid with a owner of project' do
      project_timeslot = build(:project_timeslot)
      expect(project_timeslot).to be_valid
    end
  end
end
