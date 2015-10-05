class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project_id)
    @user = user
    @project = Project.find(project_id)
    mail(to: @project.owner.email, subject: "#{@user.email} wants to join #{@project.title}")
  end

end
