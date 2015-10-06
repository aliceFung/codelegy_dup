class LanguagesController < ApplicationController

  def index
    @languages = Language.all
    render json: @languages
  end


end
