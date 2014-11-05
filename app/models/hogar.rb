class Hogar < ActiveRecord::Base
	belongs_to :user_admin, class_name: "User"
	has_many :users
	validates :user_admin_id, presence: true, uniqueness: true


end
