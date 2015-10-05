class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :availibility
      t.string :description
      t.integer :difficulty_id

      t.timestamps null: false
    end
  end
end
