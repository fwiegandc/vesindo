class Hogar < ActiveRecord::Base
	
	belongs_to :user_admin, class_name: "User"
	has_many :users
	validates :user_admin, presence: true, uniqueness: true
	has_one :direccion

	def existe_integrante?(user)

		@usuario = User.where(hogar: self, user: user).first

	end

	def enviar_email_nuevo_integrante(user)

		#Hogar.email_nuevo_integrante(user).deliver

	end

end
