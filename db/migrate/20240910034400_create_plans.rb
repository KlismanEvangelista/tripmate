class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :description
      t.string :location
      t.integer :travelers_quantity
      t.date :start_date
      t.date :end_date
      t.string :departament
      t.string :start_point
      t.references :user, null: false, foreign_key: true
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
