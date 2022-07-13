require "rails_helper"

RSpec.describe "タスクモデル機能", type: :model do
  describe "検索機能" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task1) { FactoryBot.create(:task, title: "検索テスト", status: "未着手", user: user) }
    let!(:task2) { FactoryBot.create(:task, title: "検索テスト2", status: "着手中", user: user) }
    let!(:task3) { FactoryBot.create(:task, title: "テスト", status: "完了", user: user) }
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
