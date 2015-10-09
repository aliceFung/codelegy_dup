class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project)
    @user = user
    @project = project
    p(@project.memberships)
    p @project.owner
    mail(to: @project.owner.email, subject: "#{@user.username} wants to join #{@project.title}!")
  end

  # Simple way to test production mailing. Remove once in production.
  def test_production_mail(target)
    mail(to: target, subject: "Hi.")
  end

end
