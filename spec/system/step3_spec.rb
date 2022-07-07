require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  describe "タスク管理機能", type: :system do
    describe "検索機能" do
      before do
        FactoryBot.create(:task, title: "task", status: "完了")
        FactoryBot.create(:second_task, title: "sample")
        visit tasks_path
      end

      context "タイトルであいまい検索をした場合" do
        it "検索キーワードを含むタスクで絞り込まれる" do
          fill_in "task_title", with: "task"
          click_on "検索"
          expect(page).to have_content "task"
        end
      end
      context "ステータス検索をした場合" do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          select "完了", from: "task_status"
          click_on "検索"
          expect(page).to have_content "task"
        end
      end
      context "タイトルのあいまい検索とステータス検索をした場合" do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          fill_in "task_title", with: "task"
          select "完了", from: "task_status"
          click_on "検索"
          expect(page).to have_content "task"
        end
      end
    end
  end
end
