class Hogar < ActiveRecord::Base
	
	belongs_to :user_admin, class_name: "User"
	has_many :users
	validates :user_admin, presence: true, uniqueness: true
	has_one :direccion

	def existe_integrante?(integrante)

		@usuario = User.where(hogar: self, id: integrante).first

	end

	def enviar_email_nuevo_integrante(nuevo_user)

		#Enviamos el email para integrar al usuario en su hogar
		UserMailer.nuevo_user_hogar(self.user_admin, nuevo_user).deliver

	end

end
