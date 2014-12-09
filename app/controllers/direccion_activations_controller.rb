class DireccionActivationsController < ApplicationController
	#Chequeamos que el usuario esté logueado
  before_action :logged_in_user
  before_action :usuario_con_hogar
  before_action :usuario_no_permitido_en_hogar
  before_action :direccion_no_activada
  before_action :usuario_es_administrador_del_hogar
	
  def new
  end

  def create



  	if current_user.hogar.direccion.authenticated?(:activation, activacion_params)
	  		
  			#activamos la direccion
  			current_user.hogar.direccion.activate
  			#permitimos al usuario en el hogar
  			current_user.activar_en_hogar
  			#Enviamos mensaje de que el usuario se ha activado
		      flash[:success] = "Tu direccion ha sido activada! Bienvenido a la red!"
		      redirect_to root_url
		    
		else

      
			flash[:success] = "Código incorrecto"
			render 'direccion_activations/new'

		end

  end

  private

  	def activacion_params

  		params[:direccion_activations].permit(:activation_code)[:activation_code]

  	end

    def direccion_no_activada

      unless !current_user.hogar.direccion.activated? 
        flash[:danger] = "Tu direccion ya está activada, no puedes hacerlo nuevamente"
        redirect_to root_url 
      end

    end

    def usuario_es_administrador_del_hogar

      unless current_user.hogar.user_admin == current_user 
        flash[:danger] = "Debes ser el administrador de tu hogar para activar tu dirección"
        redirect_to login_url 
      end
      
    end

end
