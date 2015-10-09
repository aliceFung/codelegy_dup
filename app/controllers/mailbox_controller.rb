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
        project = current_user.projects.find(params[:project_id])
        project.group_members - [current_user]
      elsif params[:user_id]
        User.find(params[:user_id])
      end

    respond_to do |format|
      if recipients && recipients.any?
        current_user.send_message(recipients, params[:body], params[:subject])
        format.json {head :ok}
      else
        format.json {render json: {errors:
                        ["Recipient(s) Not Found."]}, status: 404}
      end
    end
  end

  def destroy
    # @conversation = @mailbox.conversations.find(params[:id])
    # @conversation.move_to_trash(current_user)
  end

  private

  # def message_contents
  #   params.require(:message).permit(:body, :subject, :to)
  # end

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
