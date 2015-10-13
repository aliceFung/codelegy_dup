class DayTimeslot < ActiveRecord::Base
  belongs_to :day
  belongs_to :timeslot
  belongs_to :owner, polymorphic: true
end
