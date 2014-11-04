class Tag < ActiveRecord::Base

	before_save   :downcase_name
	before_save   :downcase_slug
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :slug, presence: true, uniqueness: { case_sensitive: false }
	has_many :posts
	scope :enform, -> { where(enform: true) }

	def downcase_name

		self.name = name.downcase

	end
	def downcase_slug

		self.slug = slug.downcase

	end


end
