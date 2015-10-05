class MembershipsController < ApplicationController

  #require project_owner, except: [:show]

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

  def params_list
    params.require(:membership).permit( :project_id, :user_id,
                                        :id, :type)
  end

end
