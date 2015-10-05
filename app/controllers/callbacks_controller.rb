class CallbacksController < Devise::OmniauthCallbacksController
  respond_to :json

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    respond_to do |format|
      format.html { sign_in_and_redirect @user }
      format.json { render json: @user}
    end
    
  end

end