require 'faker'

user = User.create(email: Faker::Internet.email, avatar: "http://placekitten.com/100/9#{Random.rand(10)}", name: Faker::StarWars.character)

9.times do
  genre = Faker::Book.genre
  p_tent = Tent.create(name: genre, image: "http://placekitten.com/100/9#{Random.rand(10)}")
  user.tents << p_tent
  9.times do
    post = user.posts.create!(headline: Faker::StarWars.quote.capitalize, content: Faker::Lorem.sentence, resolved: false, tent: p_tent)
  end
  3.times do
    tent = p_tent.children.create(name: Faker::Address.city + genre + Faker::Superhero.power, image: "http://placekitten.com/100/10#{Random.rand(10)}")
    user.tents << tent
    6.times do
      post = user.posts.create!(headline: Faker::StarWars.quote.capitalize, content: Faker::Hipster.paragraph, resolved: false, tent: tent)
    end
  end
end
