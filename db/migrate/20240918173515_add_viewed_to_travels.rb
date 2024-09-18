class AddViewedToTravels < ActiveRecord::Migration[7.1]
  def change
    add_column :travels, :viewed, :boolean
    add_column :travels, :default, :string
    add_column :travels, :false, :string
  end
end
