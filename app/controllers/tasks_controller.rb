class TasksController < ApplicationController
  before_action :authenticate_account!
  before_action :set_projects, only: [:new, :create]

  def index
    if cookies[:current_project_id].present?
      @project = Project.find(cookies[:current_project_id])
      @tasks = @project.tasks.order(status: :desc)
    else
      redirect_to projects_path, alert: 'No project selected'
    end
  end

  def new
    @task = Task.new(project_id: params[:project_id])
    @projects = Project.all
  end
  def create
    @task = Task.new(task_params)
    @task.account = current_account if current_account
    @task.status = 'To Do' # or whatever default status you want

    if @task.save
      redirect_to @task.project, notice: 'Task was successfully created.'
    else
      puts @task.errors.full_messages
      render 'new'
    end
  end
  def show
    @task = Task.find(params[:id])
    redirect_to project_path(@task.project)
  end

  def update_status
    @task = Task.find(params[:id])
    @task.update(status: params[:task][:status])
    redirect_to project_path(@task.project), notice: 'Task status updated'
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_path(@task.project), notice: 'Task was successfully deleted.'
  end

  private
  def set_projects
    @projects = current_account.projects
  end
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :project_id)
  end

end