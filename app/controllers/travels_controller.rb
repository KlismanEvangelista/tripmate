class TravelsController < ApplicationController
  def my_requests
    @my_requests = current_user.plans.map(&:travels).flatten
  end

  def create
    @travel = Travel.new
    @plan = Plan.find(params[:plan_id])
    @travel.user = current_user
    @travel.plan = @plan
    @travel.save!
    redirect_to my_travels_path
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

  private

  def travel_params
    params.require(:travel).permit(:status)
  end
end