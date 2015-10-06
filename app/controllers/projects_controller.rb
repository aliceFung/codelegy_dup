class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    render json: @projects, methods: [:difficulty_name, :owner]
  end

  def create
    @project = Project.new(project_params)


    if @project.save && current_user

      add_project_languages(params['languages'], @project)
      create_memberships(@project)

      render json: @project, methods: [:difficulty_name, :owner]
    else
      render json: { errors: @project.errors.full_messages }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :difficulty_id, :availability)
  end

  def add_project_languages(languages, project)
    languages.each do |lang|
      lang_id = Language.find_by_name(lang).id
      if lang_id
        ProjectLanguage.create(language_id: lang_id, project_id: project.id)
      end
    end
  end

  def create_memberships(project)
    Membership.create(
      project_id: project.id,
      user_id: current_user.id,
      participant_type: "owner")
  end
end
