# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user{n}" }
    name "MyString"
    password "password"
    password_digest "encrypted_password"
  end
end
