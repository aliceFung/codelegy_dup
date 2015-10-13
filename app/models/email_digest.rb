class EmailDigest < ActiveRecord::Base

  after_create :check_job_exists

  #currently not enforced in db model yet.
  validates :days_delayed, :presence => true

  belongs_to :user
  delegate :profile, to: :user

  # belongs_to :profile
  # delegate  :user, to: :profile

  def check_job_exists
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
      run_time, start_time = ""
      if type == :weekly
        run_time = t.end_of_week
        # start_time = t.beginning_of_week
      else
        run_time = t.end_of_day
        # start_time = t.beginning_of_day
      end

      EmailDigest.delay(queue: type, run_at: run_time).send_emails(type)
    end
  end

  #sends email then destroys emailDigest instances
  def self.send_emails(queue)
    digests = digests_to_send(queue)
    digests.each do |digest|
      user = User.find(digest.user_id)
      UserMailer.mailboxer_msg(user).deliver_now! if user
    end
    digests.destroy_all
  end

  def digests_to_send(queue)
    days = queue == :weekly ? 7 : 1
    EmailDigest.includes(:user).where('days_delayed = ?', days)
  end

end
