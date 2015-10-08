class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :language_id, null: false
      t.integer :difficulty_id
      t.text :description

      t.timestamps null: false
    end
  end
end
