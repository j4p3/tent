FactoryGirl.define do
  factory :post do
    sequence(:headline) { |n| "#{'Na' * n%4} Batman!" }
    sequence(:content) { |n| "#{'DESPITE ALL MY RAGE I AM STILL JUST ' * n%5} A rat in a cage." }
  end
end