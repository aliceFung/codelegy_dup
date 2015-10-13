class AddEmailFrequency < ActiveRecord::Migration

  def change
    add_column :users, :email_frequency, :integer
    add_index :users, :email_frequency
  end

end
