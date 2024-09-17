class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:plan).all.group_by(&:plan_id)
    @plans = Plan.where(id: @messages.keys)
  end

  def new
    @messages = Message.includes(:plan).all.group_by(&:plan_id)
    @plans = Plan.where(id: @messages.keys)
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
            :messages, partial: "messages/chanel", locals: {plan: @plan, new_message: @message}
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
