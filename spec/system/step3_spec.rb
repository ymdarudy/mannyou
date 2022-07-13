require "rails_helper"

def log_in(user)
  visit new_session_path
  fill_in :session_email, with: user.email
  fill_in :session_password, with: user.password
  click_on "commit"
end

RSpec.describe "タスク管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  describe "ソート機能" do
    context "終了期限でソートを押した場合" do
      it "終了期限が一番長いタスクが一番上に表示される" do
        FactoryBot.create(:task, title: "2日後のタスク", expired_at: Time.now + 2.days, user: user)
        FactoryBot.create(:task, title: "1日後のタスク", expired_at: Time.now + 1.days, user: user)
        log_in user
        visit tasks_path
        click_on "終了期限でソート"
        sleep 2
        first_task = first(".task_row")
        expect(first_task).to have_content "2日後のタスク"
      end
    end

    context "優先度高い順を押した場合" do
      it "優先度が一番高いタスクが一番上に表示される" do
        FactoryBot.create(:task, title: "優先度高いよ", priority: "高", user: user)
        FactoryBot.create(:task, title: "優先度低いよ", priority: "低", user: user)
        log_in user
        visit tasks_path
        click_on "優先度高い順"
        sleep 2
        first_task = first(".task_row")
        expect(first_task).to have_content "優先度高いよ"
      end
    end
  end

  describe "検索機能" do
    before do
      FactoryBot.create(:task, title: "task", status: "完了", user: user)
      FactoryBot.create(:second_task, title: "sample", user: user)
    end

    context "タイトルであいまい検索をした場合" do
      it "検索キーワードを含むタスクで絞り込まれる" do
        log_in user
        visit tasks_path
        fill_in "task_title", with: "task"
        click_on "検索"
        expect(page).to have_content "task"
      end
    end
    context "ステータス検索をした場合" do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        log_in user
        visit tasks_path
        select "完了", from: "task_status"
        click_on "検索"
        expect(page).to have_content "task"
      end
    end
    context "タイトルのあいまい検索とステータス検索をした場合" do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        log_in user
        visit tasks_path
        fill_in "task_title", with: "task"
        select "完了", from: "task_status"
        click_on "検索"
        expect(page).to have_content "task"
      end
    end
  end
end
