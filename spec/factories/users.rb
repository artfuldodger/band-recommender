FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    name "MyString"
    password "password"
    password_digest "encrypted_password"
  end
end
