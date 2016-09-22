class AddIndexOnProfileLanguage < ActiveRecord::Migration
  def change
    add_index :profile_languages, [:profile_id, :language_id]
  end
end
