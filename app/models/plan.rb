class Plan < ApplicationRecord
  belongs_to :user

  DEPARTAMENTS = [
    'Amazonas', 'Áncash', 'Apurímac', 'Arequipa', 'Ayacucho', 'Cajamarca',
    'Callao', 'Cusco', 'Huancavelica', 'Huánuco', 'Ica', 'Junín', 'La Libertad',
    'Lambayeque', 'Lima', 'Loreto', 'Madre de Dios', 'Moquegua', 'Pasco', 'Piura',
    'Puno', 'San Martín', 'Tacna', 'Tumbes', 'Ucayali'
  ]

  validates :name, :description, :location, :travelers_quantity, :start_date, :end_date, :start_point, presence: true

  validates :departament, inclusion: { in: DEPARTAMENTS, message: "%{value} no es un departamento válido" }
end
