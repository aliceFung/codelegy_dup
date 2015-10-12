class CreateDayTimeslots < ActiveRecord::Migration
  def change
    create_table :day_timeslots do |t|
      t.integer :day_id, null: false
      t.integer :timeslot_id, null: false

      t.timestamps null: false
    end
    add_index :day_timeslots, [:day_id, :timeslot_id], unique: true
  end
end
