class Profile < ActiveRecord::Base
  has_many :profile_languages, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :profile_languages
end
