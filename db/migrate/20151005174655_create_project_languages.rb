class CreateProjectLanguages < ActiveRecord::Migration
  def change
    create_table :project_languages do |t|
      t.integer :language_id, null: false
      t.integer :project_id, null: false
      t.index [:language_id, :project_id]

      t.timestamps null: false
    end
  end
end
