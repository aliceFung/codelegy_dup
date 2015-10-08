class ChangeAvailabilityOnProfiles < ActiveRecord::Migration
  def change
    rename_column :profiles, :availibility_id, :availability
    change_column :profiles, :availability, :string
  end
end
