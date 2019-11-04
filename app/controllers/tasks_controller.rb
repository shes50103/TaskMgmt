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
      flash[:success] = I18n.t("Task_flash.success_created")
    else
      render :new
      flash.now[:error] = I18n.t("Task_flash.fail_to_create")
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:success] = I18n.t("Task_flash.success_updated")
    else
      render :edit
      flash.now[:error] = I18n.t("Task_flash.fail_to_update")
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:success] = I18n.t("Task_flash.success_deleted")
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :start_time, :end_time, :priority, :status)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
