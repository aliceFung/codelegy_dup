class User < ActiveRecord::Base
  has_many :memberships
  has_many :projets, through: :memberships

  has_many :sent_emails, class_name: "Email"
end
