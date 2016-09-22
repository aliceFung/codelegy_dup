class Day < ActiveRecord::Base
  has_many :day_timeslots
  has_many :timeslots, through: :day_timeslots
end
