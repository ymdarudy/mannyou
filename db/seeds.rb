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
])

Task.create([
  { title: "初投稿してみる", content: "seedで作成", expired_at: Time.now + 1.week, user_id: 1 },
  { title: "山田の2つめ", content: "(๑>◡<๑)", expired_at: Time.now, status: "着手中", priority: "高", user_id: 1 },
  { title: "鈴木さん初タスク", content: "完了タスク", expired_at: Time.now + 1.days, status: "完了", priority: "低", user_id: 2 },
])

Label.create([
  { name: "食事" },
  { name: "睡眠" },
  { name: "運動" },
  { name: "勉強" },
  { name: "仕事" },
])
