class EmailDigest < ActiveRecord::Base

  belongs_to :user

  def send_weekly_digest

  end

  def send_daily_digest

  end

end
