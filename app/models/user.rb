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

  # returns all participating projects with limited associated info
  def project_dashboard_membership
    list = self.projects.includes(:difficulty, :languages, :memberships => :user)

    list.map do |proj|

      obj = { id:           proj.id,
              title:        proj.title,
              availability: proj.availability,
              difficulty:   proj.difficulty,
              owner?:       proj.owner == self,
              languages:    proj.languages,
            }

      if obj[:owner?]
        obj[:memberships] = proj.memberships.map do |m|
          { id: m.id,
            user: m.user.username,
            participant_type: m.participant_type }
        end
      end

      obj
    end
  end


  #get user email message details from Mailboxer Conversation obj
  def get_emails(box_type)
    #query for message
    Mailboxer::Notification.where('id IN (?)',
      #create array of Conversations objs
      self.mailbox.send(box_type).inject([]){|acc, el| acc.push(el)})
        .map do |c|
            { date: c.created_at,
              subject: c.subject,
              sender_username: c.sender.username,
              body: c.body}
        end
  end

  def mailboxer_email
    self.email
  end

  def mailboxer_username
    self.username
  end

end
