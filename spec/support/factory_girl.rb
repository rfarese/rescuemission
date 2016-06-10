require 'factory_girl'

FactoryGirl.define do
  factory :user do
    provider "twitter"
    sequence(:uid) { |n| n}
    sequence(:name) { |n| "Robert#{n}" }
    sequence(:profile_image) "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
  end
end
