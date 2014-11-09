@adminHogarVesindo = User.create!(name:  "Francisco Wiegand",
             email: "fwiegand@vesindo.com",
             password:              "w1989cf",
             password_confirmation: "w1989cf",
             activated: true,
             activated_at: Time.zone.now,
             hogar_id: 1)

@usuarioVecindario = User.create!(name:  "Francisco Proboste",
             email: "fjproboste@vesindo.com",
             password:              "2081444",
             password_confirmation: "2081444",
             activated: true,
             activated_at: Time.zone.now,
             hogar_id: 2)

User.create!(name:  "Alexander Hanke",
             email: "ahanke@vesindo.com",
             password:              "2081444",
             password_confirmation: "2081444",
             activated: true,
             activated_at: Time.zone.now,
             hogar_id: 1)

User.create!(name:  "Cristóbal Rodriguez",
             email: "cjrodriguez@vesindo.com",
             password:              "2081444",
             password_confirmation: "2081444",
             activated: true,
             activated_at: Time.zone.now,
             hogar_id: 1)

#Creamos los hogares de cada uno de los usuarios
Hogar.create!(user_admin: @adminHogarVesindo)
Hogar.create!(user_admin: @usuarioVecindario)

#Cramos los tags

Tag.create!(name: "Seguridad", slug: "seguridad", enform: true)
Tag.create!(name: "Limpieza", slug: "limpieza", enform: true)
Tag.create!(name: "Recomendación y/o favor", slug: "recomendacion_favor", enform: true)
Tag.create!(name: "Emergencia", slug: "emergencia", enform: true)
Tag.create!(name: "Convivencia", slug: "convivencia", enform: true)
Tag.create!(name: "Evento", slug: "evento", enform: false)
Tag.create!(name: "Asalto", slug: "asalto", enform: false)
Tag.create!(name: "Delito", slug: "delito", enform: false)
Tag.create!(name: "Hurto", slug: "hurto", enform: false)
Tag.create!(name: "Orden", slug: "orden", enform: false)
Tag.create!(name: "Otro", slug: "otro", enform: false)


