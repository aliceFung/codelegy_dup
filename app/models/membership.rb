class Membership < ActiveRecord::Base
  after_create :send_delayed_request_email, unless: :is_project_owner

  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: { scope: :project }, presence: true
  validates :project, presence: true

  def send_delayed_request_email
    # current_user.send_message(Project.find(self.project_id).owner, @message, "User #{current_user.username} would like to join your project: '#{@membership.project.title}!'")
    Membership.delay.send_request_email(self.user_id, self.project_id)
  end

  def is_project_owner
    self.participant_type == 'owner'
  end

  def self.send_request_email(user_id, project_id)
    user = User.find(user_id)
    project = Project.find(project_id)
    UserMailer.request_membership(user, project).deliver_now! if user && project
  end
end
