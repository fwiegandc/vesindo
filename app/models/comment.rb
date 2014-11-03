class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  default_scope -> { order('created_at ASC') }
end
