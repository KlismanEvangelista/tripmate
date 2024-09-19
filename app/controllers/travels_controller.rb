class TravelsController < ApplicationController
  before_action :query_params, only: %i[my_requests update]
  def my_requests
    if @plan_id.present?
      # Encuentra el plan por ID y obtén sus solicitudes; usa un array vacío si no se encuentra el plan
      @plan = @plan_id
      @my_requests = current_user.plans.find_by(id: @plan_id)&.travels || []
    else
      # Obtén todas las solicitudes de todos los planes del usuario
      @my_requests = current_user.plans.map(&:travels).flatten
    end
  end

  def create
    @travel = Travel.new
    @plan = Plan.find(params[:plan_id])
    @travel.user = current_user
    @travel.plan = @plan
    @ticket_available = accepted_travel_limit?(@plan)
    if @ticket_available == false
      @travel.save!
      owner = @travel.plan.user
      new_requests = owner.plans.map(&:travels).flatten.select { |t| !t.viewed && t.status == "solicitado"}

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("counter_for_user_#{owner.id}", partial: "shared/notifications_count",
            locals: { count: new_requests.count  })
        end
        format.html do
          redirect_to my_travels_path and return
        end
      end

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("notifications_for_user_##{owner.id}", partial: "shared/modal_notifications",
            locals: { requests: new_requests  })
        end
      end
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

  def mark_as_viewed
    travel = Travel.find(params[:id])
    travel.update(viewed: true)
    redirect_to my_requests_path(query: {plan_id:travel.plan.id} )
  end

  private

  def query_params
    @plan_id = params.dig(:query, :plan_id)
    @status = params.dig(:query, :status)
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
