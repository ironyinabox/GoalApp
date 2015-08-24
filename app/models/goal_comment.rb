class GoalComment < ActiveRecord::Base
  validates :goal_id, :author_id, :text, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id

  belongs_to :goal
end
