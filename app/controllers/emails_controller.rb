class EmailsController < ApplicationController

  def index
  #temp generalization, fine tune with proj owner & grp emails later
    @emails = current_user.all_user_emails
    respond_to do |format|
      format.json {render json: @emails}
    end
  end

end
