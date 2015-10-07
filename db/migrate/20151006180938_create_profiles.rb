class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :about
      t.integer :user_id, null: false
      t.integer :availibility_id
      t.integer :photo_id

      t.timestamps null: false
    end
  end
end
