class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  has_one :profile, dependent: :destroy
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

  # returns a collection of projects current_user is the owner of
  def projects_owned
    current_user.memberships.where('participant_type = ?', 'owner')
  end

  # returns a collection of projects current_user is a member of
  def project_member_in
    current_user.memberships.where('participant_type = ?', 'member')
  end

  # returns a collection of group emails from participating projects
  def group_emails
    emails=[]
    project_member_in.each do |project|
      emails.push(project.group_emails)
    end
  end

  # returns a collection of emails to project owner (current_user)
  def project_owner_emails
    emails=[]
    projects_owned.each do |project|
      emails.push(project.group_emails)
    end
  end

  #gathers all current_user emails
  def user_emails
    # sent = current_user.sent_emails
    received = project_owner_emails + group_emails
  end

end
