require 'faker'

9.times do
    Post.create!(headline: Faker::Company.bs.capitalize, content: Faker::Lorem.sentence, resolved: false)
end