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

  has_many :co_memberships, through: :projects, source: :memberships
  has_many :co_members, through: :co_memberships, source: :user

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
      end
    end
    if user.profile.photos.empty?
      picture = user.profile.photos.build
      picture.picture_from_url(auth.extra.raw_info.avatar_url) if auth.extra &&
                      auth.extra.raw_info &&
                      auth.extra.raw_info.avatar_url
    end
    user
  end


  # returns an Active Record Object of active user memberships
  def participating_memberships
    self.memberships.where('participant_type IN (?)', ['owner', 'member'])
  end

  def project_group_access?(project_id)
    self.participating_memberships.where('project_id = ?', project_id).any?
  end

  # returns an Active Record Object, of projects user requested membership in, but not rejected
  def memberships_in_projects
    self.memberships.includes(:user, project: [:languages,
                                              :difficulty,
                                              :project_languages,
                                              :members,
                                              :memberships => :user])
                    .where('participant_type IN (?)', [ 'owner',
                                                        'member',
                                                        'pending'] )
                    .map{|mem| mem.project}
  end

  # returns all participating projects with limited associated info
  # only project owner has membership details
  def project_dashboard_membership
    list = self.memberships_in_projects

    list.map do |proj|

      obj = { id:            proj.id,
              title:         proj.title,
              description:   proj.description,
              times:         proj.times,
              difficulty_name:   proj.difficulty_name,
              owner?:        proj.owner == self,
              language_urls: proj.language_urls,
              created_at:    proj.created_at
            }

      #current user member statuss
      #(if owner, includes other member info)
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
    #query for message and creates array of messages
  def get_emails(box_type)
    Mailboxer::Notification.includes(:sender).where('id IN (?)',
      self.mailbox.send(box_type).inject([]){|acc, el| acc.push(el)})
        .map do |msg|
            { date: msg.created_at,
              subject: msg.subject,
              sender_username: msg.sender.username,
              body: msg.body,
              id: msg.id
            }
        end # array of messages
  end


  # mailboxer config, triggers for email notification
  # if user has a email_frequency preference,
  # creates a EmailDigest, doesn't send email
  def user_notification_email(msg)
    if self.profile.email_frequency
      if EmailDigest.where('user_id = ?', self.id).empty?
        EmailDigest.create( user_id: self.id,
                          days_delayed: self.profile.email_frequency)
      end
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
