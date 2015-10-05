class MembershipsController < ApplicationController

  def create
    @membership = Membership.new(params_list)
    respond_to do |format|
      if @membership.save
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

  def destroy
    @membership = Membership.find(params["id"])
    respond_to do |format|
      if @membership.destroy
        format.json {head :ok}
      else
        format.json {render status: :unprocessable_entity}
      end
    end
  end

  private

  def params_list #type only used internally from Project creation
    params.require(:membership).permit(:project_id, :user_id, :id)
  end

end
