class TasksController < ApplicationController
  def index
    @tasks = Task.all
    # @tasks.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save

    redirect_to task_path(@task)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    completion_info = params[:task][:completed]
    completion_check(completion_info) if completion_info.present?

    @task.update(task_params)
    redirection(params[:redirection])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  private

  def completion_check(params)
    # fixing checkbox values to true or false for rails usage
    case params.to_i
    when 0
      params = false
    when 1
      params = true
    end
    params
  end

  def redirection(params = nil)
    # checking if different redirection is needed based on
    # information from the form
    if params.present?
      redirect_to tasks_path
    else
      redirect_to task_path(@task)
    end
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
