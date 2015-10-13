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

  # context 'Validation' do
  #   it 'should raise error when create a new day_timeslot with identical (day, timeslot, owner) combination' do
  #     new_day_timeslot = build(:profile_timeslot)
  #     new_day_timeslot.day_id = day_timeslot.day_id
  #     new_day_timeslot.timeslot_id = day_timeslot.timeslot_id
  #     new_day_timeslot.owner_id = day_timeslot.owner_id
  #     new_day_timeslot.owner_type = day_timeslot.owner_type
  #     binding.pry
  #     expect(new_day_timeslot.save).not_to raise_error(ActiveRecord::RecordInvalid)
  #   end
  # end
end
