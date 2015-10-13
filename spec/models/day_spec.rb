require 'rails_helper'

RSpec.describe Day, type: :model do
  let!(:day) { create(:day) }

  context 'Accociation' do
    it 'should respond to day_timeslots method' do
      expect(day).to respond_to(:day_timeslots)
    end

    it 'should respond to timeslots method' do
      expect(day).to respond_to(:timeslots)
    end

  end
end
