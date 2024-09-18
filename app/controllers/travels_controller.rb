class TravelsController < ApplicationController
  before_action :query_params, only: %i[my_requests update]
  def my_requests
    @plan = @plan_id
    @my_requests = current_user.plans.map(&:travels).flatten
  end

  def create
    @travel = Travel.new
    @plan = Plan.find(params[:plan_id])
    @travel.user = current_user
    @travel.plan = @plan
    @ticket_available = accepted_travel_limit?(@plan)
    if @ticket_available == false
      @travel.save!
      redirect_to my_travels_path
    end
  end

  def my_travels
    @my_travels = Travel.where(user: current_user)
  end

  def update
    @plan = @plan_id
    @travel = Travel.find(params[:id])
    @travel.update(status: @status)
    redirect_to my_requests_path(query: { plan_id: @plan })
  end

  def destroy
    @travel = Travel.find(params[:id])
    if @travel
      flash[:notice] = ''
      @travel.destroy
      redirect_to my_travels_path, status: :see_other
    else
      render my_travels_path, status: :unprocessable_entity
    end
  end

  private

  def query_params
    @plan_id = params[:query][:plan_id]
    @status = params[:query][:status]
  end

  def travel_params
    params.require(:travel).permit(:status)
  end

  def accepted_travel_limit?(plan)
    num_acepted_travels = plan.travels.where(status: 'aceptado').count
    travelers_quantity = plan.travelers_quantity

    num_acepted_travels >= travelers_quantity
  end
end
