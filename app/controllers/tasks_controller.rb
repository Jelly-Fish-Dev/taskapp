class TasksController < ApplicationController
  before_action :authenticate_account!
  
  def index
    @tasks = Task.all.group_by(&:status)
    @tasks.each do |status, tasks|
      tasks.each do |task|
        task.status ||= 'To Do'
        task.save if task.status_changed?
      end
    end
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    puts "Current Account: #{current_account.inspect}"
    @task.account = current_account if current_account
    @task.status = 'To Do' # or whatever default status you want

    if @task.save
      redirect_to @task
    else
      puts @task.errors.full_messages
      render 'new'
    end
  end


  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date)
  end

end