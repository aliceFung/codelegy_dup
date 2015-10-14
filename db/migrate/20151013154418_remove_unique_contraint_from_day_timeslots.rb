class RemoveUniqueContraintFromDayTimeslots < ActiveRecord::Migration
  def change
    remove_index :day_timeslots, [:day_id, :timeslot_id]
  end
end
