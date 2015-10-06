class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    render json: @projects, methods: [:difficulty_name, :owner]
  end

  def create
    @project = Project.create(project_params)
    render json: @project, methods: [:difficulty_name, :owner]
  end

  private

  def project_params
    params.require(:project).permit(:title, :difficulty_id)
  end
end
