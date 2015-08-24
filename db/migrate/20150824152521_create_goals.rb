class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :body
      t.integer :user_id
      t.boolean :private

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
