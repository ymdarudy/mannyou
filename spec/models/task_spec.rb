require "rails_helper"

RSpec.describe "タスクモデル機能", type: :model do
  describe "バリデーションのテスト" do
    context "タスクのタイトルが空の場合" do
      it "バリデーションに引っかかる" do
        task = Task.new(title: "", content: "失敗テスト", expired_at: Time.now)
        expect(task).not_to be_valid
      end
    end
    context "タスクの詳細が空の場合" do
      it "バリデーションに引っかかる" do
        task = Task.new(title: "失敗テスト", content: "", expired_at: Time.now)
        expect(task).to be_invalid
      end
    end

    context "終了期限が空の場合" do
      it "バリデーションに引っかかる" do
        task = Task.new(title: "失敗テスト", content: "失敗テスト", expired_at: "")
        expect(task).to be_invalid
      end
    end

    context "タスクのタイトルと詳細に内容が記載されている場合" do
      it "バリデーションが通る" do
        task = Task.new(title: "成功テスト", content: "成功テスト", expired_at: Time.now)
        expect(task).to be_valid
      end
    end
  end
end
