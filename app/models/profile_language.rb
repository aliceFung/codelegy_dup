class ProfileLanguage < ActiveRecord::Base
  belongs_to :profile
  belongs_to :language
  belongs_to :difficulty

  validates :language, uniqueness: { scope: :profile }

end
