class CallbacksController < Devise::OmniauthCallbacksController
  respond_to :json

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    respond_to do |format|
      sign_in(@user)
      format.html { redirect_to root_path }
      format.json { render json: @user }
    end

  end

end