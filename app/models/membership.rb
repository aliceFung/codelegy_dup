class Membership < ActiveRecord::Base
  after_create :send_request_email

  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: { scope: :project }, presence: true
  validates :project, presence: true

  def send_request_email
    Membership.delay.send_request_email(self.user_id, self.project_id)
  end

  def self.send_request_email(user_id, project_id)
    user = User.find_by_id(user_id)
    project = Project.find_by_id(project_id)
    UserMailer.request_membership(user, project_id) if user && project
  end
end
