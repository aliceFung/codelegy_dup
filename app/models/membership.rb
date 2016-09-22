class Membership < ActiveRecord::Base


  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: { scope: :project }, presence: true
  validates :project, presence: true

  def is_project_owner
    self.participant_type == 'owner'
  end

end
