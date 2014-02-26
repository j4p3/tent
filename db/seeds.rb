require 'faker'

5.times do
    Tag.create!(title: Faker::Commerce.color)
end
9.times do |index|
    post = Post.create!(headline: Faker::Company.bs.capitalize, content: Faker::Lorem.sentence, resolved: false)
    post.tags << Tag.where(id: 1 .. index % 6)
end