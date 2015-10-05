class User < ActiveRecord::Base
  has_many :projects, through: :memberships
  has_many :sent_emails, class_name: "Email"
end
