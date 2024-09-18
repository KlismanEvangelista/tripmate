class UpdateNilViewedToFalseInTravels < ActiveRecord::Migration[7.1]
  def up
    Travel.where(viewed: nil).update_all(viewed: false)
  end

  def down
    Travel.where(viewed: false).update_all(viewed: nil)
  end
end
