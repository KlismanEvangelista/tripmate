class Travel < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  has_many :reviews

  validates :user_id, presence: true, uniqueness: { scope: :plan_id }
  before_create :check_accepted_travel_max_quantity

  private

  def check_accepted_travel_max_quantity
    if status == 'aceptado'
      num_acepted_travels = plan.travels.where(status: 'aceptado').count
      travelers_quantity = plan.travelers_quantity

      max_quantity_travelers = num_acepted_travels >= travelers_quantity

      errors.add(:base, 'Se ha alcanzado el número máximo de solitudes aceptadas.') if max_quantity_travelers
      throw :abort if max_quantity_travelers
    end
  end
end
