class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    @tasks = Task.all.order(expired_at: :desc) if params[:sort_expired]
    @tasks = Task.all.order(priority: :desc) if params[:sort_priority]
    if params[:task]
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = Task.status_search(status).title_search(title)
      elsif title.present?
        @tasks = Task.title_search(title)
      elsif status.present?
        @tasks = Task.status_search(status)
      end
    end
    @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
