module DireccionesHelper

	
	def dame_direccion_sin_numero(direccion_completa)
		@direccionSinNumero = direccion_completa.data["address_components"][1]["long_name"]
	end

	def dame_numero_direccion(direccion_completa)
		@numeroCalle = direccion_completa.data["address_components"][0]["long_name"]
	end

	def dame_comuna(direccion_completa)
		@comuna = direccion_completa.data["address_components"][3]["long_name"]
	end
	def dame_region(direccion_completa)
		@region = direccion_completa.data["address_components"][5]["long_name"]
	end
	def dame_pais(direccion_completa)
		@pais = direccion_completa.data["address_components"][6]["long_name"]
	end

end
