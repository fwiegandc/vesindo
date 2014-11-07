class Megusta < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :post, presence: true
  validates :user, presence: true

  validates_uniqueness_of :megusta, scope: [:post_id, :user_id]


end
