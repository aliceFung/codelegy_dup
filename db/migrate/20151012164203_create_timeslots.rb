class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps null: false
    end
  end
end
