class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :title
      t.integer :language_id, null: false
      t.integer :difficulty_id
      t.text :description
      t.string :url

      t.timestamps null: false
    end
  end
end
