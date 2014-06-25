FactoryGirl.define do
  factory :user do
    name "toto"
    email "sample@example.com"
    password "password"
    password_confirmation "password"

    factory :user_admin do
      admin true
    end
  end
end
