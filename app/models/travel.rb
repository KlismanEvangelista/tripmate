class Travel < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  has_many :reviews
end
