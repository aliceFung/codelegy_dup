class Difficulty < ActiveRecord::Base
  has_many :projects
  has_many :profile_languages
end
