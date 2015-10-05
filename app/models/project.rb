class Project < ActiveRecord::Base
  has_many :member_tables
  has_many :users, through: :member_tables
  has_many :project_languages
  has_many :languages, through: :project_languages

  belongs_to :difficulty

  validates :title, presence: true
end
