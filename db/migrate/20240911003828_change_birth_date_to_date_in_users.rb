class ChangeBirthDateToDateInUsers < ActiveRecord::Migration[7.1]
  def up
    # Usa la conversión explícita en PostgreSQL
    change_column :users, :birth_date, 'date USING birth_date::date'
  end

  def down
    # Si necesitas revertir el cambio, asegúrate de especificar el tipo de datos original
    change_column :users, :birth_date, :string
  end
end
