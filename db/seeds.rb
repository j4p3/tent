require 'faker'
require 'firebase'

fb_repo = TentApi::Application.config.clients.firebase_repo
fb_root = TentApi::Application.config.clients.firebase_root
firebase = Firebase::Client.new("https://#{fb_repo}.firebaseio.com/")

user = User.create(email: Faker::Internet.email, avatar: "http://placekitten.com/100/9#{Random.rand(10)}", name: Faker::StarWars.character, password: 'password')

first_interest = Faker::Beer.style
second_interest = "WeWork Labs"

first_p_tent = Tent.create(name: first_interest, desc: "Fans of #{first_interest}", image: "http://placekitten.com/100/9#{Random.rand(10)}")
second_p_tent = Tent.create(name: second_interest, desc: "#{second_interest} members", image: "http://placekitten.com/100/9#{Random.rand(10)}")
user.tents << first_p_tent
user.tents << second_p_tent

9.times do
  first_post = ({
    user_id: user.id,
    headline: "#{Faker::StarWars.character} and #{Faker::Beer.name}",
    content: Faker::Hipster.sentence,
    resolved: false,
    tent_id: first_p_tent.id,
    created_at: Firebase::ServerValue::TIMESTAMP,
  })
  second_post = ({
    user_id: user.id,
    headline: "#{Faker::Company.catch_phrase} in #{Faker::StarWars.planet}",
    content: Faker::Hipster.sentence,
    resolved: false,
    tent_id: second_p_tent.id,
    created_at: Firebase::ServerValue::TIMESTAMP,
  })

  first_post_record = firebase.push("#{fb_root}/tents/#{first_p_tent.id}/posts", first_post.as_json())
  second_post_record = firebase.push("#{fb_root}/tents/#{second_p_tent.id}/posts", second_post.as_json())

  4.times do
    firebase.push("#{fb_root}/tents/#{first_p_tent.id}/posts/#{first_post_record.body['name']}/stream", {
      device: '',
      image: { uri: "http://thecatapi.com/api/images/get" },
      name: user.name,
      # post_id: first_post_record.body['name'],
      text: Faker::Hipster.sentence,
      created_at: Firebase::ServerValue::TIMESTAMP,
    })
    firebase.push("#{fb_root}/tents/#{second_p_tent.id}/posts/#{second_post_record.body['name']}/stream", {
      device: '',
      image: { uri: "http://thecatapi.com/api/images/get" },
      name: user.name,
      # post_id: second_post_record.body['name'],
      text: Faker::Hipster.sentence,
      created_at: Firebase::ServerValue::TIMESTAMP,
    })
  end
end

3.times do
  town = Faker::Address.city
  first_tent = first_p_tent.children.create(name: "#{first_interest} in #{town}", desc: "Fans of #{first_interest} in #{town}", image: "http://placekitten.com/100/10#{Random.rand(10)}")
  user.tents << first_tent

  second_tent = second_p_tent.children.create(name: "WeWork Labs #{town}", desc: "Labs members in #{town}", image: "http://placekitten.com/100/10#{Random.rand(10)}")
  user.tents << second_tent

  6.times do
    first_post = ({
      user_id: user.id,
      headline: "#{Faker::StarWars.quote}",
      content: Faker::Hipster.sentence,
      resolved: false,
      # tent_id: first_tent.id,
      created_at: Firebase::ServerValue::TIMESTAMP,
    })
    second_post = ({
      user_id: user.id,
      headline: "#{Faker::Company.catch_phrase}",
      content: Faker::Company.bs.capitalize,
      resolved: false,
      # tent_id: second_tent.id,
      created_at: Firebase::ServerValue::TIMESTAMP,
    })

    first_post_record = firebase.push("#{fb_root}/tents/#{first_tent.id}/posts", first_post.as_json())
    second_post_record = firebase.push("#{fb_root}/tents/#{second_tent.id}/posts", second_post.as_json())

    4.times do
      firebase.push("#{fb_root}/tents/#{first_tent.id}/posts/#{first_post_record.body['name']}/stream", {
        device: '',
        image: { uri: "http://thecatapi.com/api/images/get" },
        name: user.name,
        # post_id: first_post_record.body['name'],
        text: Faker::Hipster.sentence,
        created_at: Firebase::ServerValue::TIMESTAMP,
      })
      firebase.push("#{fb_root}/tents/#{second_tent.id}/posts/#{second_post_record.body['name']}/stream", {
        device: '',
        image: { uri: "http://thecatapi.com/api/images/get" },
        name: user.name,
        # post_id: second_post_record.body['name'],
        text: Faker::Hipster.sentence,
        created_at: Firebase::ServerValue::TIMESTAMP,
      })
    end
  end
end
