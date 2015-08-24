class UserComment < ActiveRecord::Base
  validates :user_id, :author_id, :text, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id

  belongs_to :user
end
