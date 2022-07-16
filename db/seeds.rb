# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  { name: "山田", email: "test@test.com", password: "123123", admin: true },
  { name: "鈴木", email: "test2@test.com", password: "123123" },
  { name: "遠藤", email: "test3@test.com", password: "123123" },
  { name: "森塚", email: "test4@test.com", password: "123123" },
  { name: "門脇", email: "test5@test.com", password: "123123" },
  { name: "中村", email: "test6@test.com", password: "123123" },
  { name: "吉田", email: "test7@test.com", password: "123123" },
  { name: "西川", email: "test8@test.com", password: "123123" },
  { name: "佐藤", email: "test9@test.com", password: "123123" },
  { name: "青野", email: "test10@test.com", password: "123123" },
  { name: "金子", email: "test11@test.com", password: "123123" },
  { name: "齋藤", email: "test12@test.com", password: "123123" },
  { name: "丸岡", email: "test13@test.com", password: "123123" },
])

Label.create([
  { name: "食事" },
  { name: "睡眠" },
  { name: "運動" },
  { name: "勉強" },
  { name: "仕事" },
  { name: "趣味" },
  { name: "春" },
  { name: "夏" },
  { name: "秋" },
  { name: "冬" },
])

Task.create([
  { title: "初投稿してみる", content: "seedで作成", expired_at: Time.now + 1.week, user_id: 1 },
  { title: "山田の2つめ", content: "(๑>◡<๑)", expired_at: Time.now, status: "着手中", priority: "高", user_id: 1 },
  { title: "山田の3つめ", content: "食事関連", expired_at: Time.now, status: "着手中", priority: "高", user_id: 1, label_ids: [1, 7] },
  { title: "山田の4つめ", content: "睡眠関連", expired_at: Time.now, status: "着手中", priority: "高", user_id: 1, label_ids: [2, 8] },
  { title: "山田の5つめ", content: "運動関連", expired_at: Time.now, status: "着手中", priority: "高", user_id: 1, label_ids: [3, 9] },
  { title: "鈴木さん初タスク", content: "完了タスク", expired_at: Time.now + 1.days, status: "完了", priority: "低", user_id: 2 },
  { title: "鈴木さんセカンド", content: "勉強系", expired_at: Time.now + 1.days, status: "完了", priority: "低", user_id: 2, label_ids: [4, 10] },
  { title: "鈴木さんサード", content: "仕事系", expired_at: Time.now + 1.days, status: "完了", priority: "低", user_id: 2, label_ids: [5] },
  { title: "鈴木さんフォース", content: "趣味系", expired_at: Time.now + 1.days, status: "完了", priority: "低", user_id: 2, label_ids: [6] },
  { title: "鈴木さんフィフス", content: "これで最後", expired_at: Time.now + 1.days, status: "完了", priority: "低", user_id: 2 },
])
