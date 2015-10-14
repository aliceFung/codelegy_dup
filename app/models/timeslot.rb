class Timeslot < ActiveRecord::Base
  has_many :day_timeslots
  has_many :days, through: :day_timeslots
end
