class UserMailer < ApplicationMailer
  default :from => "no-reply@codelegy.xyz"

  def request_membership(user, project)
    @project = project
    @user = user # not really needed if details in site msgs
    mail(to: @project.owner.email, subject: "#{@user.username} wants to join #{@project.title}!")
  end

  # generic inbox notification
  def mailboxer_msg(recipient)
    @recipient = recipient
    mail(to: @recipient.email, subject: "You have a new message at Codelegy")
  end

end
