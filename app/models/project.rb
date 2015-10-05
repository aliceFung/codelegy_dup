class Project < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def owner
    self.members.where('memberships.participant_type = ?', 'owner')[0]
  end
end
