class TravelsController < ApplicationController
  before_action :query_params, only: %i[my_requests]
  def my_requests
    @plan = @query_params
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
    @travel = Travel.find(params[:id])
    @travel.update(status: "aceptado")
    redirect_to my_requests_path
  end

  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy
    redirect_to my_requests_path
  end

  def mark_as_viewed
    travel = Travel.find(params[:id])
    travel.update(viewed: true)
    redirect_to my_requests_path(query:travel.plan.id)
  end

  private

  def query_params
    @query_params = params[:query]
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
