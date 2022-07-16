FactoryBot.define do
  factory :task do
    title { "Factoryで作ったデフォルトのタイトル１" }
    content { "Factoryで作ったデフォルトのコンテント１" }
    expired_at { Time.now }
  end

  factory :second_task, class: Task do
    title { "Factoryで作ったデフォルトのタイトル２" }
    content { "Factoryで作ったデフォルトのコンテント２" }
    expired_at { Time.now }
  end
end
