FactoryBot.define do
  factory :user do
    name { "鈴木" }
    email { "test@test.com" }
    password { "123123" }
  end
  factory :admin_user, class: User do
    name { "山田" }
    email { "test2@test.com" }
    password { "123123" }
    admin { "有り" }
  end
end
