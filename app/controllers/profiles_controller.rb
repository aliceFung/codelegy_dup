class ProfilesController < ApplicationController

  def create
    @profile = Profile.new(whitelisted_profile_params)
    # binding.pry
    if @profile.save
      render json: @profile, status: 200
    else
      render nothing: true , status: 404
    end
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if current_user == @user
      if @profile.update(whitelisted_profile_params)
        render json: @profile.to_json(include: :profile_languages), status: 200
      else
        render nothing: true , status: 404
      end
    else
      render nothing: true , status: 401
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
                                      :difficulty_id]
                                    })
  end

end
