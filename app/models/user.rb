class User < ActiveRecord::Base

  acts_as_messageable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  has_one :profile, dependent: :destroy
  has_many :memberships
  has_many :projects, through: :memberships

  has_one :email_digest, dependent: :destroy

  after_create :create_profile

  def self.from_omniauth(auth)
    user = where(email: auth.info.email)[0]
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.save
    else
      user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = auth.info.name
        user.password = Devise.friendly_token[0,20]
        # profile.photo_url = auth.extra.raw_info.avatar_url
      end
    end
    user
  end

  # returns a collection of projects user is the owner of
  # eager loading to prevent n+1 queries
  def projects_owned
    self.memberships.includes(:project =>
                              [:languages, :memberships => :user])
                    .where('participant_type = ?', 'owner')
  end

  # returns a collection of projects user is a member of
  # eager loading to prevent n+1 queries
  def project_member_of
    self.memberships.includes(:project => :languages).where('participant_type = ?', 'member')
  end

  # returns an array, not an Active Record Object, of projects user is active in (owner or member)
  def participating_projects
    # projects_owned + project_member_of
    self.memberships.includes(:project =>
                              [:languages, :memberships => :user])
                    .where('participant_type = ? OR participant_type = ?', 'owner', 'member')
  end

  # returns all participating projects with limited associated info
  def project_dashboard_membership
    list = self.projects.includes(:difficulty, :languages, :memberships => :user)

    list.map do |proj|

      obj = { id:           proj.id,
              title:        proj.title,
              description:  proj.description,
              availability: proj.availability,
              difficulty_name:   proj.difficulty_name,
              owner?:       proj.owner == self,
              languages:    proj.languages,
              created_at:   proj.created_at
            }

      if obj[:owner?]
        obj[:memberships] = proj.memberships.map do |m|
          { id: m.id,
            user: m.user.username,
            participant_type: m.participant_type }
        end
        obj[:pending_member_count] = proj.memberships.where("participant_type = ?", 'pending').length
      else
        obj[:member_status] = proj.memberships.where('user_id = ?', self.id).first.participant_type
      end

      obj
    end
  end


  #returns an array of user messages with limited details
  def get_emails(box_type)
    #query for message
    Mailboxer::Notification.includes(:sender).where('id IN (?)',
      #create array of Conversations objs
      self.mailbox.send(box_type).inject([]){|acc, el| acc.push(el)})
        .map do |c|
            { date: c.created_at,
              subject: c.subject,
              sender_username: c.sender.username,
              body: c.body,
              id: c.id
            }
        end # array of messages
  end

  # mailboxer config, triggers for email notification
  def user_notification_email(msg)
    if self.email_frequency
      EmailDigest.create(user_id: self.id)
    else
      User.delay.send_notification_email(self.id)
    end
    return nil #to prevent default email sending
  end

  # uses our own mailing method
  def self.send_notification_email(user_id)
    user = User.find(user_id)
    UserMailer.mailboxer_msg(user).deliver_now!
  end

  # mailboxer config
  def mailboxer_name
    self.username
  end

end
