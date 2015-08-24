class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.text :text
      t.integer :user_id
      t.integer :author_id
      t.timestamps null: false
    end
    add_index :user_comments, :user_id
    add_index :user_comments, :author_id
  end
end
