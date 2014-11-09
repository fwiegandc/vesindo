@adminHogarVesindo = User.create!(name:  "Francisco Wiegand",
             email: "fwiegand@vesindo.com",
             password:              "w1989cf",
             password_confirmation: "w1989cf",
             activated: true,
             activated_at: Time.zone.now,
             hogar_id: 1)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now,
              hogar_id: n+1)
end

User.all.each do |user|

  Hogar.create!(user_admin: user)

end

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

users = User.order(:created_at).take(6)
50.times do

  content = Faker::Lorem.sentence(5)
  users.each do |user|



    @post = user.posts.create!(content: content, tag_id: rand(1..6))
    3.times do

      user.comments.create!(content: content, post: @post)

    end
  end

end

#Rellenamos con me gusta

@posts = Post.all

@posts.each do |post|

  users.each do |user|

      if [true, false].sample

       Megusta.create!(user: user, post: post)

      end

  end

end