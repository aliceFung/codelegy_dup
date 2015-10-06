class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    render json: @projects, methods: [:difficulty_name, :owner]
  end

  def create
    @project = Project.new(project_params)

    if @project.save && current_user
      Membership.create(project_id: @project.id,
                     user_id: current_user.id,
                     participant_type: "owner")

      render json: @project, methods: [:difficulty_name, :owner]
    else
      render json: { errors: @project.errors.full_messages }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :difficulty_id)
  end
end
