class MailboxController < ApplicationController

  before_action :get_mailbox

  def index
    @inbox_msgs = current_user.get_emails(:inbox)
    # @sentbox = current_user.get_emails(:sentbox)
    # @trash = current_user.get_emails(:trash)
    respond_to do |format|
      format.json {render json: @inbox_msgs}
    end
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
