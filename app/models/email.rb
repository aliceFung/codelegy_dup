class Email < ActiveRecord::Base
  # belongs_to :user
  # belongs_to :project


  # #Creates an email history for membership request and project owner.
  # #Email instance for database, not the actual email UserMailer sent.
  # # This contains content that the requester included that can only be accessed by project owner when they are logged in.
  # # This is sent only to project owner.
  # def self.membership_history(content, membership)
  #   Email.create( user_id: membership.user_id,
  #           project_id: membership.project_id,
  #              content: content)
  # end


end
