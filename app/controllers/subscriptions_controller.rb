class SubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!

  def resubscribe
    sendgrid_api = SendgridApi.new
    sendgrid_api.remove_from_unsub_list(params[:email])
    render json: { nothing: true, status: 200 }
  end
end
