require "rails_helper"

def log_in(user)
  visit new_session_path
  fill_in :session_email, with: user.email
  fill_in :session_password, with: user.password
  click_on "commit"
end

RSpec.describe "ラベル機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:label2) { FactoryBot.create(:label, name: "睡眠") }
  let!(:task) { FactoryBot.create(:task, user: user, labels: [label]) }
  let!(:task2) { FactoryBot.create(:task, user: user, labels: [label2]) }
  context "タスクの新規作成時に" do
    it "タスクに複数のラベルが付けて登録でき、詳細画面で表示される" do
      log_in user
      visit new_task_path
      fill_in "タスク名", with: "ラベルテスト"
      fill_in "内容", with: "どうだろうか"
      fill_in "終了期限", with: Time.now
      check "食事"
      check "睡眠"
      click_on "commit"
      expect(page).to have_content "Task was successfully created."
      expect(page).to have_content "食事"
      expect(page).to have_content "睡眠"
    end
  end
  context "タスクの編集時に" do
    it "ラベルの付け替えができる（食事ラベルを外して、睡眠ラベルをつける）" do
      log_in user
      visit edit_task_path(task)
      uncheck "食事"
      check "睡眠"
      click_on "commit"
      expect(page).not_to have_content "食事"
      expect(page).to have_content "睡眠"
    end
  end
  context "タスク一覧画面でラベル検索をすると" do
    it "そのラベルがついたタスクが表示される（詳細画面でラベルを確認）" do
      log_in user
      visit tasks_path
      select "食事", from: "task_label_id"
      click_on "検索"
      task_count = all(".task_row").size
      expect(task_count).to eq 1
      click_on "Show"
      expect(page).to have_content "食事"
    end
  end
end
