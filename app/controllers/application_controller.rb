class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :basic_auth if Rails.env.production?
  before_action :login_required

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV["BASIC_AUTH_NAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def login_required
    redirect_to new_session_path unless current_user
  end

  def task_search(tasks)
    tasks = tasks.order(expired_at: :desc) if params[:sort_expired]
    tasks = tasks.order(priority: :desc) if params[:sort_priority]
    if params[:task]
      tasks = tasks.title_search(params[:task][:title]) if params[:task][:title]
      tasks = tasks.status_search(params[:task][:status]) if params[:task][:status].present?
      if params[:task][:label_id].present?
        task_ids = Labeling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        tasks = tasks.where(id: task_ids)
      end
    end
    tasks = tasks.order(created_at: :desc).page(params[:page]).per(3)
  end
end
