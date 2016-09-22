class EmailsJoinTable < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :user
      t.references :project
      t.text :content
      t.boolean :to_everyone, default: false
    end
  end
end
