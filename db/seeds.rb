require 'faker'

user = User.create(email: Faker::Internet.email, avatar: "http://placekitten.com/100/9#{Random.rand(10)}", name: Faker::Name.name)
5.times do |index|
    Tag.create!(title: "#{Faker::Commerce.color} #{index}")
end
9.times do |index|
    post = user.posts.create!(headline: Faker::Company.bs.capitalize, content: Faker::Lorem.sentence, resolved: false)
    post.tags << Tag.where(id: 1 .. index % 6)
end