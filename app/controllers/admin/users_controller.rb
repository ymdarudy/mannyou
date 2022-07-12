class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to admin_users_path, notice: "#{@user.name}さんを追加しました！"
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks
    @tasks = @tasks.order(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :desc) if params[:sort_priority]
    if params[:task]
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = @tasks.status_search(status).title_search(title)
      elsif title.present?
        @tasks = @tasks.title_search(title)
      elsif status.present?
        @tasks = @tasks.status_search(status)
      end
    end
    @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(3)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name}さんを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.name}さんを削除しました！"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
