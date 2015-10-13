class ProfilesController < ApplicationController
  
  def update
    @user = User.find(params[:profile][:user_id])
    @profile = @user.profile

    create_timeslots(params['timeslots'], @profile) if params['timeslots']
    if current_user == @user
      if @profile.update(whitelisted_profile_params)
        render json: @profile.to_json(include: [:profile_languages, :user]), status: 200
      else
        render nothing: true , status: 404
      end
    else
      render nothing: true , status: 401
    end
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if @profile
      render json: @profile.to_json(include: [:profile_languages, :user]), status: 200
    else
      render nothing: true , status: 404
    end
  end

  private

  def whitelisted_profile_params
    params.require(:profile).permit(:about,
                                    :user_id,
                                    :availability,
                                    :photo_id,
                                    {profile_languages_attributes:[
                                      :language_id,
                                      :difficulty_id, :id, :_destroy]
                                    })
  end


  def create_timeslots(timeslots, profile)
    timeslots.each do |timeslot|
      start_time = Time.at(timeslot[:start_time]).utc
      end_time = Time.at(timeslot[:end_time]).utc
      new_timeslot = Timeslot.find_or_create_by(start_time: start_time, end_time: end_time)
      new_day = Day.find_by_name(timeslot[:day])
      DayTimeslot.find_or_create_by(day_id: new_day.id, timeslot_id: new_timeslot.id,
                          owner_id: profile.id, owner_type: profile.class)
    end
  end

end
