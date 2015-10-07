class User < ActiveRecord::Base

  acts_as_messageable

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

  # returns a collection of projects user is the owner of
  def projects_owned
    self.memberships.where('participant_type = ?', 'owner')
  end

  # returns a collection of projects user is a member of
  def project_member_in
    self.memberships.where('participant_type = ?', 'member')
  end

  # returns a collection of group emails from participating projects
  def group_emails
    emails=[]
    project_member_in.each do |project|
      emails.push(project.group_emails)
    end
  end

  # returns a collection of emails to project owner
  def project_owner_emails
    emails=[]
    projects_owned.each do |project|
      emails.push(project.group_emails)
    end
  end

  #gathers all self emails
  def all_user_emails
    # sent = self.sent_emails
    received = project_owner_emails + group_emails
    # binding.pry
  end

  #create obj with email message details user mailboxer gem methods
  def get_emails(box)
    self.mailbox.send(box).map do |conv|
      # receipt = conv.receipts_for(self).first
      { body: conv.receipts_for(self).first.message.body,
        subject: conv.receipts_for(self).first.message.subject,
        username: conv.receipts_for(self).first.message.sender.username,
        date: conv.receipts_for(self).first.message.created_at}
    end
  end

  def mailboxer_email
    self.email
  end

  def mailboxer_username
    self.username
  end



end
