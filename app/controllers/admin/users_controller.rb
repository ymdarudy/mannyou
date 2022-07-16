class Admin::UsersController < ApplicationController
  before_action :only_admin_user
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.select(:id, :name, :email, :admin).order(:id).eager_load(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.name}さんを追加しました！"
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks
    @tasks = task_search(@tasks)
  end

  def edit
  end

  def update
    before_edit_name = @user.name
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{before_edit_name}さんを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name}さんを削除しました！"
    else
      redirect_to admin_users_path, notice: "#{@user.name}さんは唯一の管理者ユーザーのため削除できませんでした！"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def only_admin_user
    redirect_to tasks_path, notice: "管理者以外アクセス禁止！" unless current_user.admin_before_type_cast
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
