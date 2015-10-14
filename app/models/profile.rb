class Profile < ActiveRecord::Base

  has_many :profile_languages, dependent: :destroy
  has_many :day_timeslots, as: :owner
  has_many :photos, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :profile_languages, allow_destroy: true

  validates :user_id, presence: true
  validates :email_frequency, :inclusion => [1, 7],
                              :allow_nil => true



  def times
    self.day_timeslots.includes(:day, :timeslot).pluck(:"days.name", :"timeslots.start_time", :"timeslots.end_time")
  end

  def photo_url
    photos.first.picture.url
  end

end
