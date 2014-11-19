class DireccionesController < ApplicationController

	#verificar que el usuario este logueado
	#verificar que el usuario no tenga un hogar establecido ya

	def show
	end

	def new

		@direccion = Direccion.new

	end

	def create

		@direccionCompleta = Geocoder.search(params.require(:direccion).permit(:direccion)).first
		@bloque = params.require(:direccion).permit(:bloque)
		@dpto = params.require(:direccion).permit(:dpto)

		if cumple_requisitos?(@direccionCompleta)

			if existe_hogar?(@direccionCompleta, @bloque, @dpto)

				#Si existe el hogar, enviamos una notificacion al admin del hogar para que lo active

			else

				#Si no existe, entonces creamos el hogar y ponemos al usuario como admin
				#Al hogar le damos la direccion actual
				#Marcamos al usuario como no activado
				#Luego se activa desde el controlador adecuado

			end

		else

			#Enviamos mensaje diciendo que no cumple requisitos, con una notificación en cada caso

		end
		redirect_to root_path

	end

	private

	def cumple_requisitos?(direccion)

		#Aqui todos los requisitos que debe cumplir el hogar, aparte de los de active record
		true
	end

	def direccion_create_params

		params.require(:direccion).permit(:direccion, :numero, :bloque, :dpto)

	end

	def direccion_confirmation_params
	end

end
