class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@codelegy.xyz"
  layout 'mailer'
end
