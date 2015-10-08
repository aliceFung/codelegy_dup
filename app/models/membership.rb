class Membership < ActiveRecord::Base
  after_create :send_delayed_request_email

  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: { scope: :project }, presence: true
  validates :project, presence: true

  def send_delayed_request_email
    Membership.delay.send_request_email(self.user_id, self.project_id)
  end

  def self.send_request_email(user_id, project_id)
    user = User.find_by_id(user_id)
    project = Project.find_by_id(project_id)
    p("========================================================+++++==========")
    p("========================================================+++++==========")
    p("========================================================+++++==========")
    p(user, project)
    p("========================================================+++++==========")
    p("========================================================+++++==========")
    p("========================================================+++++==========")

    UserMailer.request_membership(user, project).deliver_now! if user && project
  end

  # def self.membership_list(user)

  # end
end
