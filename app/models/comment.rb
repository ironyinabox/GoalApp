class Comment < ActiveRecord::Base
  validates :text, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true

end
