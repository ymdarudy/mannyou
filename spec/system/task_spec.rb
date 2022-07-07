# require "rails_helper"

# RSpec.describe "タスク管理機能", type: :system do
#   before do
#     FactoryBot.create(:task)
#     FactoryBot.create(:second_task)
#     FactoryBot.create(:task, title: "付け加えた名前１")
#     FactoryBot.create(:task, title: "付け加えた名前２")
#     FactoryBot.create(:second_task, title: "付け加えた名前３", content: "付け加えたコンテント")
#   end

#   describe "新規作成機能" do
#     context "タスクを新規作成した場合" do
#       it "作成したタスクが表示される" do
#         visit new_task_path
#         fill_in "タスク名", with: "新規テスト"
#         fill_in "内容", with: "どうだろうか"
#         fill_in "終了期限", with: Time.now
#         click_on "登録する"
#         expect(page).to have_content "新規テスト"
#       end
#     end
#   end

#   describe "一覧表示機能" do
#     let!(:task) { FactoryBot.create(:task, title: "task") }
#     before do
#       visit tasks_path
#     end

#     context "一覧画面に遷移した場合" do
#       it "作成済みのタスク一覧が表示される" do
#         expect(page).to have_content "task"
#       end
#     end

#     context "タスクが作成日時の降順に並んでいる場合" do
#       it "新しいタスクが一番上に表示される" do
#         first_task = first(".task_row")
#         expect(first_task).to have_content "task"
#       end
#     end
#   end

#   describe "ソート機能" do
#     context "終了期限でソートを押した場合" do
#       it "終了期限が一番長いタスクが一番上に表示される" do
#         task1 = FactoryBot.create(:task, title: "2日後のタスク", expired_at: Time.now + 2.days)
#         task2 = FactoryBot.create(:task, title: "1日後のタスク", expired_at: Time.now + 1.days)
#         visit tasks_path
#         click_on "終了期限でソート"
#         sleep 2
#         first_task = first(".task_row")
#         expect(first_task).to have_content "2日後のタスク"
#       end
#     end
#   end

#   describe "詳細表示機能" do
#     context "任意のタスク詳細画面に遷移した場合" do
#       it "該当タスクの内容が表示される" do
#         show_task = FactoryBot.create(:task, title: "詳細確認用")
#         visit task_path(show_task)
#         expect(page).to have_content "詳細確認用"
#       end
#     end
#   end
# end
