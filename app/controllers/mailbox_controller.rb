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

  def create
    recipients =
      if params[:project_id]
        current_user.projects.group_members
      elsif params[:user_id]
        User.find(params[:user_id])
      else
        []
      end

    receipt = current_user.send_message(recipients, params[:body], params[:subject])

    @message = {  date: receipt.message.created_at,
                  subject: receipt.message.subject,
                  sender_username: receipt.message.sender.username,
                  body: receipt.message.body,
                  id: receipt.message.id }

    respond_to do |format|
      format.json {head :ok}
    end

  end

  def destroy
    # @conversation = @mailbox.conversations.find(params[:id])
    # @conversation.move_to_trash(current_user)
  end

  private

  def receipt_for_sent_message

  end

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
