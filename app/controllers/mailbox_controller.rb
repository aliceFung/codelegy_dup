class MailboxController < ApplicationController

  before_action :require_project_membership

  def index
    @inbox_msgs = current_user.get_emails(:inbox)
    # @sentbox = current_user.get_emails(:sentbox)
    # @trash = current_user.get_emails(:trash)
    respond_to do |format|
      format.json {render json: @inbox_msgs}
    end
  end

  # creates a new mailboxer message
  def create
    recipients, subject = build_email_msg
    respond_to do |format|
      if recipients && recipients.any?
        current_user.send_message(recipients, params[:body], subject)
        format.json {head :ok}
      else
        format.json {render json: {errors:
                        ["Recipient(s) Not Found."]}, status: 404}
      end
    end
  end

  # updates user settings for email frequency
  # nil == immediate, 1 == daily digest, 7 == weekly digest
  def update
    params[:email_frequency]
  end

  def destroy
    # @conversation = @mailbox.conversations.find(params[:id])
    # @conversation.move_to_trash(current_user)
  end

  private

  def build_email_msg
    subject = ""
    recipients =
      if params[:project_id]
        project = current_user.projects.find(params[:project_id])
        subject = "[#{project.title}]: "
        project.group_members - [current_user]
      elsif params[:user_id]
        User.find(params[:user_id])
      end
    subject+= params[:subject]

    return recipients, subject
  end

  def require_project_membership
    if params[:project_id]
      if !current_user.project_group_access?(params[:project_id])
        respond_to do |format|
          format.json {render json: {errors: ["You must be a member first!"]}, status: 403}
        end
      end
    end
  end

end
