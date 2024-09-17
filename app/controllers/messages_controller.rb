class MessagesController < ApplicationController
  def new
    @plan = Plan.find(params[:plan_id])
    @message = Message.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @message = Message.new(message_params)
    @message.plan = @plan
    @message.user = current_user
    if @message.save
      redirect_to new_plan_message_path(@plan)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
