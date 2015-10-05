class CreateDifficulties < ActiveRecord::Migration
  def change
    create_table :difficulties do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
