class Language < ActiveRecord::Base
  has_many :project_languages
  has_many :profile_languages
end
