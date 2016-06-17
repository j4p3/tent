require 'faker'
require 'firebase'


#############################################################################
#   DUMMY DATA
#############################################################################

class Generator
  attr_accessor(:fb_repo, :fb_root, :firebase, :user, :interest)

  # config

  def initialize(attributes={})
    self.fb_repo = attributes[:fb_repo] ||
      TentApi::Application.config.clients.firebase_repo
    self.fb_root = attributes[:fb_root] ||
      TentApi::Application.config.clients.firebase_root
    self.firebase = attributes[:firebase] ||
      Firebase::Client.new("https://#{fb_repo}.firebaseio.com/")

    self.user = attributes[:user] ||
      User.create(email: Faker::Internet.email,
        avatar: "http://placekitten.com/100/9#{Random.rand(10)}",
        name: Faker::StarWars.character,
        password: 'password')

    self.interest = attributes[:interest] ||
      "Cool Kids' Club"
  end

  # generator functions

  def populate_tent(tent)
    6.times do
      post = make_post(tent)

      rand(4..8).times do
        make_message(tent, post)
      end
    end
  end

  def make_tent(parent, options={})
    options[:name] ||= interest
    parent_id = parent ? parent.id : nil
    Tent.create(name: options[:name], desc: "#{options[:name]} members", image: "http://placekitten.com/100/9#{Random.rand(10)}", parent_id: parent_id)
  end

  def make_post(tent, options={})
    Post.create(
      user: self.user,
      headline: "#{Faker::Company.catch_phrase} in #{Faker::StarWars.planet}",
      content: Faker::Hipster.sentence,
      resolved: false,
      tent_id: tent.id
    )
  end

  def make_message(tent, post)
    firebase.push("#{fb_root}/tents/#{tent.id}/posts/#{post.id}/stream", {
      device: '',
      image: { uri: "http://thecatapi.com/api/images/get" },
      user: self.user.as_json(except: [:authentication_token, :password_digest, :updated_at, :created_at]),
      text: Faker::Hipster.sentence,
      created_at: Firebase::ServerValue::TIMESTAMP,
    })
  end
end

# create and populate root

user = User.create(email: Faker::Internet.email,
        avatar: "http://placekitten.com/100/9#{Random.rand(10)}",
        name: Faker::StarWars.character,
        password: 'password')
generator = Generator.new({user: user})

p_tent = generator.make_tent(nil, {name: generator.interest})
user.tents << p_tent
generator.populate_tent(p_tent)

# create and populate children

3.times do
  town = Faker::Address.city
  tent = generator.make_tent(p_tent, {name: "#{generator.interest} #{town}"})
  user.tents << tent

  generator.populate_tent(tent)

  summer = generator.make_tent(tent, {name: "Summer 2016 #{generator.interest} #{town}"})
  generator.populate_tent(summer)
  winter = generator.make_tent(tent, {name: "Winter 2016 #{generator.interest} #{town}"})
  generator.populate_tent(winter)
  fall = generator.make_tent(tent, {name: "Fall 2016 #{generator.interest} #{town}"})
  generator.populate_tent(fall)
end

#############################################################################
#   SEED DATA
#############################################################################

InteractionType.create(name: 'close')
InteractionType.create(name: 'value')
InteractionType.create(name: 'ping')
