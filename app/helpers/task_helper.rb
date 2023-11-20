module TaskHelper
    def create_task_in_project(project, task_params)
        project.tasks.create(task_params)
      end
    
end
