# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Francisco Wiegand",
             email: "franciscowiegand@gmail.com",
             password:              "w1989cf",
             password_confirmation: "w1989cf",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do

  content = Faker::Lorem.sentence(5)
  users.each do |user|

    @post = user.posts.create!(content: content)
    3.times do

      user.comments.create!(content: content, post_id: @post.id)

    end
  end

end
