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

  describe "検索機能" do
    let!(:task1) { FactoryBot.create(:task, title: "検索テスト", status: "未着手") }
    let!(:task2) { FactoryBot.create(:task, title: "検索テスト2", status: "着手中") }
    let!(:task3) { FactoryBot.create(:task, title: "テスト", status: "完了") }
    context "scopeメソッドでタイトルのあいまい検索をした場合" do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search("検索")).to include(task1, task2)
        expect(Task.title_search("検索")).not_to include(task3)
        expect(Task.title_search("検索").count).to eq 2
      end
    end
    context "scopeメソッドでステータス検索をした場合" do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search("未着手")).to include(task1)
        expect(Task.status_search("未着手")).not_to include(task2, task3)
        expect(Task.status_search("未着手").count).to eq 1
      end
    end
    context "scopeメソッドでタイトルのあいまい検索とステータス検索をした場合" do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.status_search("未着手").title_search("検索")).to include(task1)
        expect(Task.status_search("未着手").title_search("検索")).not_to include(task2, task3)
        expect(Task.status_search("未着手").title_search("検索").count).to eq 1
      end
    end
  end
end
