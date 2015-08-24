class Goal < ActiveRecord::Base
  validates :user_id, :body, presence: true
  validates :private, inclusion: {in: [true, false]}

  belongs_to :user

  has_many :comments,
    class_name: "GoalComment",
    foreign_key: :goal_id

  after_initialize :ensure_private, :ensure_completion_defaults_to_false

  def toggle_completion
    self.completed = !self.completed
    self.save!
  end

  private

  def ensure_private
    self.private ||= false
  end

  def ensure_completion_defaults_to_false
    self.completed ||= false
  end

end
