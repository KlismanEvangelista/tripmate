class PlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    @plans = Plan.all
  end

  def new
    @departament = Plan::DEPARTAMENTS
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user
    @plan.save!
    redirect_to plans_path, notice: 'Plan creado exitosamente.'
    # if @plan.save
    #   redirect_to my_plans_path, notice: 'Plan creado exitosamente.'
    # else
    #   respond_to do |format|
    #     format.html { render :new }
    #     format.json { render json: { errors: @plan.errors.full_messages }, status: :unprocessable_entity }
    #   end
    # end
  end

  def show
  end

  def edit
    @departament = Plan::DEPARTAMENTS
  end

  def update
    @plan.update(plan_params)
    redirect_to plans_path
  end

  def destroy
    @plan.destroy
    redirect_to my_plans_path, status: :see_other
  end

  def my_plans
    @my_plans = Plan.all.select { |plan| plan.user_id == current_user.id }
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :description, :travelers_quantity, :location, :start_date, :end_date, :departament, :start_point)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
