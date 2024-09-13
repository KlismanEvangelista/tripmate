class RecreateLatitudeAndLongitudeInPlans < ActiveRecord::Migration[7.1]
  def change
    remove_column :plans, :latitude, :string
    remove_column :plans, :longitude, :string

    add_column :plans, :latitude, :float
    add_column :plans, :longitude, :float
  end
end
