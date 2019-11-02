class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
      flash[:success] = "已新增任務"
    else
      render :new
      flash.now[:error] = "新增失敗，請重新確認輸入之資料"
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:success] = "已更新任務"
    else
      render :edit
      flash.now[:error] = "更新失敗，請重新確認輸入之資料"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:success] = "已刪除任務"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :start_time, :end_time, :priority, :status)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
