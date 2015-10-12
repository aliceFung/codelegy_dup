class LanguagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @languages = Language.all
    render json: @languages, include: [:suggestions]
  end


end
