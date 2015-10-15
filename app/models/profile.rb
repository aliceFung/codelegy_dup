class Profile < ActiveRecord::Base

  after_update :update_email_digest

  has_many :profile_languages, dependent: :destroy
  has_many :day_timeslots, as: :owner
  has_many :timeslots, through: :day_timeslots
  has_many :photos, dependent: :destroy
  belongs_to :user
  delegate :email_digest, to: :user

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :profile_languages, allow_destroy: true

  validates :user_id, presence: true
  validates :email_frequency, :inclusion => [1, 7],
                              :allow_nil => true



  def times
    self.day_timeslots.includes(:day, :timeslot).pluck(:"days.name", :"timeslots.start_time", :"timeslots.end_time")
  end

  def photo_url
    photos.first.picture.url if photos.first
  end

  def update_email_digest
    if self.email_digest
      if self.email_frequency.nil?
        User.delay.send_notification_email(self.user.id)
        self.email_digest.destroy
      elsif self.email_frequency == 7
        self.email_digest.update(days_delayed: 7)
      else
        self.email_digest.update(days_delayed: 1)
      end
    end
  end



end
