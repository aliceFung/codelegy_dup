class FixColumnNameToAvailabilty < ActiveRecord::Migration
  def change
    rename_column :projects, :availibility, :availability
  end
end
