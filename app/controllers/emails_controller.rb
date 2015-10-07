class EmailsController < ApplicationController

  before_action :get_mailbox

  def index
    @inbox = @mailbox.inbox
    @sentbox = @mailbox.sentbox
    @trash = @mailbox.trash
    respond_to do |format|
      format.json {render json: @inbox, methods: [:email_details]}
    end
  end


  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
