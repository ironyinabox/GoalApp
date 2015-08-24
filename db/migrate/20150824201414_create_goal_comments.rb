class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.text :text
      t.integer :goal_id
      t.integer :author_id
      t.timestamps null: false
    end
    add_index :goal_comments, :goal_id
    add_index :goal_comments, :author_id
  end
end
