class Suggestion < ActiveRecord::Base
  belongs_to :language
  belongs_to :difficulty
end
