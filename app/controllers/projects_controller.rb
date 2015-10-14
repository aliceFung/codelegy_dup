class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index #eager loading testing needed later
    @projects = Project.includes(:languages, :difficulty, :memberships, :members, :day_timeslots => [:day, :timeslot]).paginate(page: params[:page], per_page: 24).order(created_at: 'DESC')
    render json: @projects, methods: [:difficulty_name, :owner, :language_urls, :times]
  end

  def show
    @project = Project.find(params[:id])
    render json: @project, methods: [:difficulty_name, :owner, :language_urls, :times]
  end

  def create

    @project = Project.new(project_params)
    if @project.save && current_user
      create_timeslots(params['timeslots'], @project) if params['timeslots']

      create_project_languages(params['languages'], @project) if params['languages']
      create_memberships(@project)
      # binding.pry
      render json: @project, methods: [:difficulty_name, :owner, :language_urls, :times]
    else
      render json: { errors: @project.errors.full_messages }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :difficulty_id, :availability,
     :description)
  end

  def create_timeslots(timeslots, project)
    timeslots.each do |timeslot|
      start_time = Time.at(timeslot[:start_time]).utc
      end_time = Time.at(timeslot[:end_time]).utc
      new_timeslot = Timeslot.find_or_create_by(start_time: start_time, end_time: end_time)
      new_day = Day.find_by_name(timeslot[:day])
      DayTimeslot.find_or_create_by(day_id: new_day.id, timeslot_id: new_timeslot.id,
                          owner_id: project.id, owner_type: project.class)
    end
  end

  def create_project_languages(languages, project)
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




  # def create_timeslot
  #   start_time = Time.at(params[:start]).utc
  #   end_time = Time.at(params[:end]).utc
  #   timeslot = Timeslot.find_or_create_by(start_time: start_time, end_time: end_time)

  #   DayTimeslot.find_or_create_by(day_id: params[:day], timeslot_id: timeslot.id,
  #                                 owner_id: )
  #   binding.pry
  # end