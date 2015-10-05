class CreateMemberTables < ActiveRecord::Migration
  def change
    create_table :member_tables do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :participant_type, null: false
      t.index [:project_id, :user_id]

      t.timestamps null: false
    end
  end
end
