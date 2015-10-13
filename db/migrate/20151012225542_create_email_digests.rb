class CreateEmailDigests < ActiveRecord::Migration
  def change
    create_table :email_digests do |t|
      t.references :user, null: false
      t.integer :days_delayed
      t.timestamps null: false
    end
    add_index :email_digests, :user_id, unique: true
  end
end
