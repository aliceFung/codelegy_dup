class ProjectLanguage < ActiveRecord::Base
  validates :project_id, :language_id, presence: true

  belongs_to :project
  belongs_to :language
end
