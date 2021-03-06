class MembershipsController < ApplicationController

  before_action :get_project_owner, only: [:create, :update]
  before_action :require_project_owner, only: [:update]

  def index
    @membership_projects = current_user.project_dashboard_membership
    respond_to do |format|
      format.json {render json: @membership_projects }
    end
  end

  def create
    @membership = Membership.new(params_list)
    @membership.user_id = current_user.id
    @message = params["content"] || params[:content] || "User #{current_user.username} would like to join your project!"
    respond_to do |format|
      if @membership.save
        new_membership_request
        format.json {render json: @membership}
      else
        format.json {render json: {errors: ["There was an error with your request. Please try again."]}, status: 522}
      end
    end
  end

  def show
    @membership = Membership.find(params["id"])
    respond_to do |format|
      format.json {render json: @membership}
    end
  end

  def update
    @membership = Membership.find(params["id"])
    membership_status = @membership.participant_type
    respond_to do |format|
      if @membership.update(params_list)
        send_notification(membership_status, params_list["participant_type"])
        format.json {render json: @membership}
      else
        format.json {render json: {errors: ["There was an error with your request. Please try again."]}, status: 522}
      end
    end
  end


  private

  #does not allow user_id to prevent malicious membership generation
  def params_list
    params.require(:membership).permit( :project_id, :id, :participant_type)
  end

  def get_project_owner
    if params["membership"]
      if params["membership"]['id']
        @project_owner = Membership.find(params["membership"]['id']).project.owner
      elsif params["membership"]["project_id"]
        proj = Project.find_by_id(params["membership"]['project_id'])
        @project_owner = proj.owner if proj
      end
    end

    unless @project_owner
      respond_to do |format|
        format.json {render json: {errors: ["Project Not Found."]}, status: 404}
      end
    end
  end

  # only allows project owner to modify memberships
  def require_project_owner
    unless (current_user.id == @project_owner.id)
      respond_to do |format|
        format.json {render json: {errors: ["You must be the owner of this content!"]}, status: 403}
      end
    end
  end

  def new_membership_request
    if current_user != @project_owner
      current_user.send_message(@project_owner, @message, "User #{current_user.username} would like to join your project: '#{@membership.project.title}!'")
    end
  end


  # User is accepted
    # Everyone in the project gets a message
  # User is rejected
    # Rejected user gets a message.
  def send_notification(before, after)
    send_membership_status_update(after) if before == 'pending'
  end

  def send_membership_status_update(after)
    if after == 'member'
      grp_members = @membership.project.group_members - [current_user]
      current_user.send_message(grp_members, "#{@membership.user.username} has been added to #{@membership.project.title}!", "#{@membership.project.title} has a new member!")
    elsif after == 'rejected'
      current_user.send_message(@membership.user, "Unfortunately, you were rejected to work on project #{@membership.project.title}. Sign in to codelegy find another project to join.", "Sorry!")
    end
  end


end
