class DayTimeslot < ActiveRecord::Base
  belongs_to :day
  belongs_to :timeslot
  belongs_to :owner, polymorphic: true

  validates :day_id, uniqueness: { scope: [:timeslot_id, :owner_id, :owner_type] }
  validates :day_id, :timeslot_id, :owner_type, :owner_id, 
            presence: true
end
