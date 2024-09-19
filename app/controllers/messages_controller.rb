class MessagesController < ApplicationController
  def index
    my_plans_creates = current_user.plans
    my_request_accepted = Travel.where(user: current_user, status: "aceptado").includes(:plan).map(&:plan)
    @plans = my_plans_creates.or(Plan.where(id: my_request_accepted.map(&:id)))
  end

  def new
    my_plans_creates = current_user.plans
    my_request_accepted = Travel.where(user: current_user, status: "aceptado").includes(:plan).map(&:plan)
    @plans = my_plans_creates.or(Plan.where(id: my_request_accepted.map(&:id)))
    @plan = Plan.find(params[:plan_id])
    @message = Message.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @message = Message.new(message_params)
    @message.plan = @plan
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            :messages, partial: "messages/message", locals: { message: @message, user: current_user }
          )
        end
        format.html { redirect_to new_plan_message_path(@plan) }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
