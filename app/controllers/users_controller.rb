class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_user, only: %i[show edit update]
  before_action :ensure_user, only: %i[show edit update]

  def new
    redirect_to tasks_path if current_user.present?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @tasks = current_user.tasks
    @tasks = @tasks.order(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :desc) if params[:sort_priority]
    if params[:task]
      @tasks = @tasks.title_search(params[:task][:title]) if params[:task][:title]
      @tasks = @tasks.status_search(params[:task][:status]) if params[:task][:status].present?
    end
    @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(3)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "編集しました！"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_user
    redirect_to tasks_path unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
