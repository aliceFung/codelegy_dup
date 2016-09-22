class MoveEmailFrequencyToProfile < ActiveRecord::Migration
  def change
    remove_index :users, :email_frequency
    remove_column :users, :email_frequency, :integer

    add_column :profiles, :email_frequency, :integer
    add_index :profiles, :email_frequency
  end
end
