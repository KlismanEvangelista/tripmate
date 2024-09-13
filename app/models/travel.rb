class Travel < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  has_many :reviews

  validates :user_id, presence: true, uniqueness: { scope: :plan_id }
end
