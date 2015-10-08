class MembershipsController < ApplicationController

  before_action :get_project_owner, only: [:update]
  before_action :require_project_owner, only: [:update]

  def index
    # @memberships = Membership.all
    @memberships = current_user.project_dashboard_membership
    # binding.pry
    respond_to do |format|
      format.json {render json: @memberships}
    end
  end

  def create
    @membership = Membership.new(params_list)
    @membership.user_id = current_user.id
    # binding.pry
    respond_to do |format|
      if @membership.save
        # Email.membership_history(params["content"], @membership)
        current_user.send_message(@project_owner, "User #{current_user.username} would like to join your project!", "User #{current_user.username} would like to join your project!")
        format.json {render json: @membership}
      else
        format.json {render json: {errors: ["There was an error with your request. Please try again."]}, status: 522}
      end
    end
  end

  # def show
  #   @membership = Membership.find(params["id"])
  #   respond_to do |format|
  #     format.json {render json: @membership}
  #   end
  # end

  def update
    @membership = Membership.find(params["id"])
    respond_to do |format|
      if @membership.update(params_list)
        format.json {render json: @membership}
      else
        format.json {render json: {errors: ["There was an error with your request. Please try again."]}, status: 522}
      end
    end
  end


  # def destroy
  #   @membership = Membership.find(params["id"])
  #   respond_to do |format|
  #     if @membership.destroy
  #       format.json {head :ok}
  #     else
  #       format.json {render status: :unprocessable_entity}
  #     end
  #   end
  # end

  private

  #does not allow user_id to prevent malicious membership generation
  def params_list
    params.require(:membership).permit( :project_id, :id, :type, :participant_type)
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

end
