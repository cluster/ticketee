FactoryGirl.define do
  sequence(:email) { |n| "users#{n}@example.com" }
  factory :user do
    name "toto"
    email { generate(:email) }
    password "password"
    password_confirmation "password"

    factory :user_admin do
      admin true
    end
  end
end
