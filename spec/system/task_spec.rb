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

  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        log_in user
        visit new_task_path
        fill_in "タスク名", with: "新規テスト"
        fill_in "内容", with: "どうだろうか"
        fill_in "終了期限", with: Time.now
        click_on "登録する"
        expect(page).to have_content "新規テスト"
      end
    end
  end

  describe "一覧表示機能" do
    let!(:new_task) { FactoryBot.create(:task, title: "new_task", user: user) }

    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        log_in user
        visit tasks_path
        expect(page).to have_content "task"
      end
    end

    context "タスクが作成日時の降順に並んでいる場合" do
      it "新しいタスクが一番上に表示される" do
        log_in user
        visit tasks_path
        first_task = first(".task_row")
        expect(first_task).to have_content "new_task"
      end
    end
  end

  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        log_in user
        show_task = FactoryBot.create(:task, title: "詳細確認用", user: user)
        visit task_path(show_task)
        expect(page).to have_content "詳細確認用"
      end
    end
  end
end
