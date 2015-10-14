class AddNullConstraintOnEmailDigestDaysDelayed < ActiveRecord::Migration
  def change
    change_column :email_digests, :days_delayed, :integer, null: false
    add_index :email_digests, :days_delayed
  end
end
