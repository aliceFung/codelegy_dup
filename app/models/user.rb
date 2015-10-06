class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]


  has_many :memberships
  has_many :projects, through: :memberships
  has_many :project_emails, through: :projects, source: :emails

  has_many :sent_emails, class_name: "Email"

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def projects_owned
    current_user.memberships.where('participant_type = ?', 'owner')
  end


  #gathers sent emails, project owner emails, group project emails
  def user_emails
    sent = current_user.sent_emails
    received = []
    projects_owned.each do |project|
      received.push(project.emails)
    end
  end

end
