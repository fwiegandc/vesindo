class DireccionActivationsController < ApplicationController
	#Chequeamos que el usuario esté logueado
	
  def edit

  		#Buscamos la direccion que hay que activar
  		@direccion = Direccion.find_by(activation_digest: params[:id])

  		if params[:email]
	  		@usuario_por_activar = User.find(email: params[:email])
	  		#Buscamos en el hogar del usuario adminque exista tal usuario
	  		@usuario_hogar = current_user.hogar.existe_integrante?(@usuario_por_activar)
	  		#Buscamos el usuario que tiene
		    if @usuario_hogar && @usuario_hogar.activated? && !@usuario_hogar.permitido_en_hogar

		      @usuario_hogar.activar_en_hogar
		      flash[:success] = "El usuario #{@usuario_hogar.name} ya está en tu hogar."
		      #Enviar notificacion a @usuarioHogar de que ha sido activado en la cuenta
		      redirect_to root_url
		    end
		end


  end

end
