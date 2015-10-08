class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project)
    @user = user
    @project = project
    p(@user, @project)
    mail(to: "miosicla@fakeinbox.com", subject: "#{@user} wants to join #{@project}")
  end

  # Simple way to test production mailing. Remove once in production.
  def test_production_mail(target)
    mail(to: target, subject: "Hi.")
  end

end
