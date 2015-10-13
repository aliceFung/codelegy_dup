class Profile < ActiveRecord::Base
  has_many :profile_languages, dependent: :destroy

  has_many :day_timeslots, as: :owner

  belongs_to :user
  accepts_nested_attributes_for :profile_languages, allow_destroy: true

  validates :user_id, presence: true


  def times
    self.day_timeslots.includes(:day, :timeslot).pluck(:"days.name", :"timeslots.start_time", :"timeslots.end_time")
  end
end
