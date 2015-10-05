class Project < ActiveRecord::Base
  has_many :member_tables
  has_many :users, through: :member_tables

  validates :title, presence: true
end
