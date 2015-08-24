class Goal < ActiveRecord::Base
  validates :user_id, :body, presence: true
  validates :private, inclusion: {in: [true, false]}

  belongs_to :user

  after_initialize :ensure_private

  def ensure_private
    self.private ||= false
  end

end
