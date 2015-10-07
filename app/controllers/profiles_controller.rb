class ProfilesController < ApplicationController

  def update
    @user = User.find(params[:profile][:user_id])
    @profile = @user.profile
    # binding.pry
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
