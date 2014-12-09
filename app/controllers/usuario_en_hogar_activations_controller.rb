class UsuarioEnHogarActivationsController < ApplicationController
  #nos aseguramos de estar logueados
  before_action :logged_in_user_permitido_en_hogar?
  before_action :usuario_es_administrador_del_hogar


  def edit

  		#Buscamos el usuario que hay que activar
		@usuario_por_activar = User.find_by(email: params[:email])
		#Buscamos en el hogar del usuario admin que exista tal usuario
		@usuario_hogar = current_user.hogar.existe_integrante?(@usuario_por_activar)

		#Buscamos el usuario que tiene
			if @usuario_hogar && @usuario_hogar.activated? && !@usuario_hogar.permitido_en_hogar?

			  @usuario_hogar.activar_en_hogar
			  flash[:success] = "El usuario #{@usuario_hogar.name} ya está en tu hogar."
			  #Enviar notificacion a @usuarioHogar de que ha sido activado en la cuenta
			  redirect_to root_url
			else

			  flash[:danger] = "Ha ocurrido un error ingresando al usuario en tu hogar"
			  redirect_to root_url

			end

  end
  
end
