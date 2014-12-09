module DireccionesHelper

	
	def dame_direccion_sin_numero(direccion_completa)
		direccion_completa.route
	end

	def dame_numero_direccion(direccion_completa)
		direccion_completa.street_number
	end

	def dame_comuna(direccion_completa)
		direccion_completa.address_components_of_type(:administrative_area_level_3).first["long_name"]
	end
	def dame_region(direccion_completa)
		direccion_completa.state
	end
	def dame_pais(direccion_completa)
		direccion_completa.country
	end

end
