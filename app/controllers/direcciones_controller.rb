class DireccionesController < ApplicationController

	#verificar que el usuario este logueado
	before_action :logged_in_user
	#verificar que el usuario no tenga un hogar establecido ya
	before_action :usuario_sin_hogar
	#verificar que e
	#y todas las otras validaciones

	def new

		@direccion = Direccion.new

	end

	def create

		@direccionCompleta = Geocoder.search(params.require(:direccion).permit(:direccion)[:direccion], :params => {:countrycodes => "cl"}).first
		@bloque = params.require(:direccion).permit(:bloque)[:bloque]
		@dpto = params.require(:direccion).permit(:dpto)[:dpto]
		#buscamos la comuna
		@comuna = Comuna.find_by(name: dame_comuna(@direccionCompleta))
		@direccion = Direccion.new(direccion: dame_direccion_sin_numero(@direccionCompleta),
					numero: dame_numero_direccion(@direccionCompleta),
					bloque: @bloque,
					dpto: @dpto,
					comuna: @comuna)

		#Asignamos la geolocalización
		@direccion.loc_geographic_lat_lon(@direccionCompleta.latitude, @direccionCompleta.longitude)

		#Vemos que todos los requisitos se cumplan
		if !@direccionCompleta.city == "Santiago" || dame_direccion_sin_numero(@direccionCompleta).nil? || @comuna.nil?

			flash[:danger] = "La ciudad debe ser Santiago, en una comuna soportada por nuestro piloto, debe tener numero y nombre de direccion"
			return redirect_to new_direccion_path

		end

		if @direccion.save
				#Creamos el hogar y ponemso al user como admin
				@nuevo_hogar = Hogar.create!(user_admin: current_user)
				#Asignamos la dirección al hogar
				@direccion.hogar = @nuevo_hogar
				@direccion.save
				#Asignamos el hogar al usuario
				current_user.hogar = @nuevo_hogar
				current_user.save
				#La direccion del hogar esta como no activa por default
				#Enviamos el método de comprobación que sea para activar la carta
				@direccion.enviar_validacion
				#Notificamos al usuario de que se le ha enviado una carta para validarlo				
				flash[:success] = "Una carta ha sido enviada a tu hogar para validarte. Muchas gracias!!"
				#redireccionamos a la pagina de activacion de la direccion
				redirect_to root_path

		else


				#Si la dirección no pudo ser grabada, puede ser por distintos motivos
				#El primero, es que el hogar ya exista. En ese caso, enviamos un mail al administrador para que acepte al usuario en el hogar
				if !@direccion.errors.messages[:direccion].nil? && @direccion.errors.messages[:direccion].count == 1 && (@direccion.errors.messages[:direccion][0] == "has already been taken")

					#Buscamos el hogar donde la direccion es la actual
					@direccion_ya_ocupada = Direccion.where(direccion: dame_direccion_sin_numero(@direccionCompleta), numero: dame_numero_direccion(@direccionCompleta), bloque: @bloque, dpto: @dpto, comuna: @comuna).first
					@hogar = @direccion_ya_ocupada.hogar
					
					#Vemos que el hogar exista, si no, lo creamos para el
					#Esto es porque enviaremos cartas de publicidad que incluiran el codigo de verificacion
					#en cuyo caso, estaría la dirección pero sin hogar

					if @hogar

						#Metemos al usuario al hogar, pero no lo permitimos dentro de el al no activar permitido_en_hogar
						current_user.hogar = @hogar
						current_user.save
						flash[:success] = "Un email ha sido enviado al administrador de este hogar para que entres en el. Serás notificado cuando ello ocurra"
						@hogar.enviar_email_nuevo_integrante(current_user)
						redirect_to root_path

					else

						#Es el caso en que la direccion existe, pero no así el hogar
						@nuevo_hogar = Hogar.create!(user_admin: current_user)
						current_user.hogar = @nuevo_hogar
						current_user.save
						#y asignamos el hogar a la direccion
						@direccion_ya_ocupada.hogar = @nuevo_hogar
						@direccion_ya_ocupada.save
						flash[:success] = "Hemos detectado que ya fue enviado el código de verificación a este hogar. Seras redireccionado para insertar el codigo"
						redirect_to new_direccion_activation_path


					end

				else

					#Imprimimos los otros errores
					render 'direcciones/new'

				end				

		end

	end

	private

	def direccion_create_params

		params.require(:direccion).permit(:direccion, :numero, :bloque, :dpto)

	end

	def direccion_confirmation_params
	end

end
