class JoinUsersAndProjects < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user
      t.references :project
      t.string :participant_type, default: "pending"
    end
  end
end
