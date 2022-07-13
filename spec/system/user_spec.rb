require "rails_helper"

def log_in(user)
  visit new_session_path
  fill_in :session_email, with: user.email
  fill_in :session_password, with: user.password
  click_on "commit"
end

RSpec.describe "ユーザ管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:task) { FactoryBot.create(:task, user: user) }

  describe "ユーザ登録" do
    context "ユーザを新規登録した場合" do
      it "登録が完了しマイページに飛ぶ" do
        visit new_user_path
        fill_in :user_name, with: "佐藤"
        fill_in :user_email, with: "test3@test.com"
        fill_in :user_password, with: "123123"
        fill_in :user_password_confirmation, with: "123123"
        click_on :commit
        expect(page).to have_content "佐藤のページ"
      end
    end

    context "ユーザがログインせずタスク一覧画面に飛ぼうとした場合" do
      it "ログイン画面に遷移すること" do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "セッション機能" do
    context "必要情報を入れたら" do
      it "ログイン（マイページに自動遷移）できること" do
        log_in user
        expect(current_path).to eq user_path(user)
      end
    end

    context "ログイン後にプロフィールボタンを押すと" do
      it "自分の詳細画面(マイページ)に飛べること" do
        log_in user
        visit tasks_path
        click_on "プロフィール"
        expect(current_path).to eq user_path(user)
      end
    end

    context "一般ユーザが他人の詳細画面にとぼうとした場合" do
      it "タスク一覧画面に遷移すること" do
        log_in user
        visit user_path(admin_user)
        expect(current_path).to eq tasks_path
      end
    end

    context "ログイン後にログアウトボタンを押すと" do
      it "ログアウトができる（ログイン画面にいる）こと" do
        log_in user
        click_on "ログアウト"
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "管理画面" do
    context "管理ユーザでログイン後" do
      it "管理画面にアクセスできること" do
        log_in admin_user
        click_on "管理画面"
        expect(current_path).to eq admin_users_path
      end
    end

    context "一般ユーザでログイン後" do
      it "管理画面にアクセスできない（タスク一覧に飛ばされる）こと" do
        log_in user
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
    end

    context "管理ユーザは" do
      it "ユーザの新規登録ができること" do
        log_in admin_user
        visit new_admin_user_path
        fill_in :user_name, with: "佐藤"
        fill_in :user_email, with: "test3@test.com"
        fill_in :user_password, with: "123123"
        fill_in :user_password_confirmation, with: "123123"
        click_on :commit
        expect(page).to have_content "佐藤さんを追加しました！"
      end

      it "ユーザの詳細画面にアクセスできること" do
        log_in admin_user
        visit admin_user_path(user)
        expect(current_path).to eq admin_user_path(user)
      end

      it "ユーザの編集画面からユーザを編集できること" do
        log_in admin_user
        visit edit_admin_user_path(user)
        fill_in :user_name, with: "田中"
        fill_in :user_password, with: "123123"
        fill_in :user_password_confirmation, with: "123123"
        click_on :commit
        expect(page).to have_content "田中"
      end

      it "ユーザの削除をできること" do
        log_in admin_user
        visit admin_users_path
        click_on "Destroy", match: :first
        page.accept_confirm
        expect(page).to have_content "鈴木さんを削除しました！"
      end
    end
  end
end
