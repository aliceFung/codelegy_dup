class Project < ActiveRecord::Base
  has_many :members, through: :memberships, source: :user

  def owner
    self.members.find(type: "owner")
  end
end
