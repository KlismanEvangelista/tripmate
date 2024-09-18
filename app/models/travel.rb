class Travel < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  has_many :reviews

  validates :user_id, presence: true, uniqueness: { scope: :plan_id }

  after_create_commit :broadcast_notifications_count

  def broadcast_notifications_count
    owner = self.plan.user
    new_requests_count = owner.plans.map(&:travels).flatten.select { |t| !t.viewed }.count

    broadcast_prepend_to "counter_for_user_#{owner.id}",
                        target: "counter",
                        partial: "shared/notifications_count",
                        locals: { count: new_requests_count }
  end
end
