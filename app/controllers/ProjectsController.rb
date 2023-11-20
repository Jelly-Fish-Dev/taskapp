class ProjectsController < ApplicationController
    before_action :authenticate_account!

    def index
        @projects = current_account.projects
        @message = 'No projects' if @projects.empty?
      end

    def add_account
      @project = Project.find(params[:id])
      @account = Account.find_by(email: params[:email])
      @project.account_projects.create(account: @account)
      @projects = Project.joins(:account_projects)
                   .where(account_projects: { account_id: current_account.id })

    end

    def new
        @project = Project.new
      end
      
      def create
        @project = current_account.projects.build(project_params)
        if @project.save
          redirect_to @project, notice: 'Project was successfully created.'
        else
          render :new
        end
      end
      def show
        @project = Project.find(params[:id])
        if @project.nil?
          redirect_to projects_path, alert: 'Project not found'
        else
          @tasks = @project.tasks.sort_by { |task| Task.statuses[task.status] }.group_by(&:status).to_a.reverse.to_h
        end
      end
      def update
        @project = Project.find(params[:id])
    
        if @project.update(project_params)
          redirect_to @project
        else
          render :edit
        end
      end      
      private
      
    def project_params
        params.require(:project).permit(:name)
    end

end
  