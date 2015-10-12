class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project)
    @project = project
    @user = user # not really needed if details in site msgs
    mail(to: @project.owner.email, subject: "#{@user.username} wants to join #{@project.title}!")
  end

  # Simple way to test production mailing. Remove once in production.
  def test_production_mail(target)
    mail(to: target, subject: "Hi.")
  end

end
