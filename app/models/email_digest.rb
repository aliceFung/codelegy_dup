class EmailDigest < ActiveRecord::Base

  belongs_to :user

  def send_weekly_digest
    EmailDigest.where('queue = ?', 7)
  end

  def send_daily_digest
    result = EmailDigest.where('queue = ?', 1)
  end

  # def send_digest()

  # end

end
