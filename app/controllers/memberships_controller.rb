class MembershipsController < ApplicationController

  # before_action :authenticate_user!
  before_action :require_project_owner, except: [:create, :show]

  def create
    @membership = Membership.new(params_list)
    @membership.user_id = current_user.id
    respond_to do |format|
      if @membership.save
        # Email.create(params["content"])
        format.json {render json: @membership}
      else
        format.json {render status: :unprocessable_entity}
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
    respond_to do |format|
      if @membership.update(params_list)
        format.json {render json: @membership}
      else
        format.json {render status: :unprocessable_entity}
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
    params.require(:membership).permit( :project_id, :id, :type)
  end

  # only allows project owner to modify memberships
  def require_project_owner
    if params["membership"]['id']
      project_owner = Membership.find(params["membership"]['id']).project.owner
    else
      project_owner = Project.find(params["membership"]['project_id']).owner
    end
    current_user.id == project_owner.id
  end

end
