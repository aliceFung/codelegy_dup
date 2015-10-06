class ProfilesController < ApplicationController

  def create
    @profile = Profile.new(whitelisted_profile_params)
    if @profile.save
      render json: @profile, status: 200
    else
      render nothing: true , status: 404
    end
  end

  def update
  end

  private

  def whitelisted_profile_params
    params.require(:profile).permit(:about,
                                    :user_id,
                                    :availability_id,
                                    :photo_id,
                                    {profile_languages_attributes:[
                                      :language_id,
                                      :difficulty_id]
                                    })
  end

end
