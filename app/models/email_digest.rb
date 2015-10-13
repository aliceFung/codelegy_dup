class EmailDigest < ActiveRecord::Base

  after_create :check_job_exists

  validates :user_id, :presence => true,
                      :uniqueness => true
  validates :days_delayed, :presence => true

  belongs_to :user
  delegate :profile, to: :user

  def check_job_exists
    # binding.pry
    if self.days_delayed == 7
      add_to_DJ_queue(:weekly)
    else
      add_to_DJ_queue(:daily)
    end
  end

  # adds a Delayed Job only if it doesn't exist yet.
  def add_to_DJ_queue(type)
    if Delayed::Job.find_by_queue(type).nil?
      t = Time.now
      run_time =
        if type == :weekly
          t.end_of_week
        else
          t.end_of_day
        end

      EmailDigest.delay(queue: type, run_at: run_time).send_emails(type)
    end
  end

  #sends email then destroys emailDigest instances
  def self.send_emails(queue)
    digests = EmailDigest.digests_to_send(queue)
    digests.each do |digest|
      user = User.find(digest.user_id)
      UserMailer.mailboxer_msg(user).deliver if user
    end
    digests.destroy_all
  end

  def self.digests_to_send(queue)
    days = queue == :weekly ? 7 : 1
    EmailDigest.includes(:user).where('days_delayed = ?', days)
  end

end
