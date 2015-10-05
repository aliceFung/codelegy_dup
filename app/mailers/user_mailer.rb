class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project)
    @user = user
    @project = project
    mail(to: @project.owner.email, subject: "#{@user.email} wants to join #{@project.title}")
  end

end
