class AddTravelRefToReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :travel, null: false, foreign_key: true
  end
end
