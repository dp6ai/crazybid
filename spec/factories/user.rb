# This will guess the User class
FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    user_name "testuser"
    email "mail@mail.com"
    password "password"
    admin false
  end
end