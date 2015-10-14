class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :picture, null: false
      t.integer :profile_id, null: false

      t.timestamps null: false
    end
  end
end
