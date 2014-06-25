FactoryGirl.define do
  factory :user do
    name "toto"
    email "test@test.fr"
    password "password"
    password_confirmation "password"
  end
end
