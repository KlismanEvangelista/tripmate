class Message < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "plan_#{plan.id}_messages",
                        partial: "messages/message",
                        locals: { message: self, user: user }
  end
end
