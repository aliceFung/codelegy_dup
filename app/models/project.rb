class Project < ActiveRecord::Base

  has_many :project_languages
  has_many :languages, through: :project_languages

  belongs_to :difficulty

  validates :title, presence: true

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def owner
    self.members.where('memberships.participant_type = ?', 'owner')[0]
  end

  def difficulty_name
    difficulty ? difficulty.name : "None"
  end

  def group_emails
    self.emails.where('to_everyone = ?', true)
  end

  def language_urls
    self.languages.select(:name, :url)
  end

  def group_members
    self.members.where('participant_type = ? OR
                        participant_type = ?', 'owner', 'member')
  end

end
