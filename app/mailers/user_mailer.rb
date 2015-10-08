class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project)
    @user = user
    @project = project
    p("========================================================+++++==========")
    p("========================================================+++++==========")
    p("========================================================+++++==========")

    p(@user)
    p(@project)

    p("========================================================+++++==========")
    p("========================================================+++++==========")
    p("========================================================+++++==========")

    mail(to: @project.owner.email, subject: "#{@user.email} wants to join #{@project.title}")
  end

  # Simple way to test production mailing. Remove once in production.
  def test_production_mail(target)
    mail(to: target, subject: "Hi.")
  end

end
