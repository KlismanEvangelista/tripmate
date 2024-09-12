class Review < ApplicationRecord
  belongs_to :user
  belongs_to :travel

  validates :title, presence: true
  validates :comment, presence: true
  validates :rating, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
  validates :travel_id, presence: true, uniqueness: true
end
