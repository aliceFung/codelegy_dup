class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    render json: @projects, methods: [:difficulty_name, :owner]
  end

  def create

  end
end
