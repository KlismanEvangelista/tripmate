class Plan < ApplicationRecord
  belongs_to :user

  DEPARTAMENTS = [
    'Amazonas', 'Áncash', 'Apurímac', 'Arequipa', 'Ayacucho', 'Cajamarca',
    'Callao', 'Cusco', 'Huancavelica', 'Huánuco', 'Ica', 'Junín', 'La Libertad',
    'Lambayeque', 'Lima', 'Loreto', 'Madre de Dios', 'Moquegua', 'Pasco', 'Piura',
    'Puno', 'San Martín', 'Tacna', 'Tumbes', 'Ucayali'
  ]

  validates :name, :description, :location, :travelers_quantity, :start_date, :end_date, :start_point, presence: true
  validates :start_date_cannot_be_in_the_past
  validates :end_date_cannot_be_in_the_past
  validates :departament, inclusion: { in: DEPARTAMENTS, message: "%{value} no es un departamento válido" }

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "No puede ser en el pasado")
    end
  end

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today && end_date < start_date
      errors.add(:end_date, "La fecha de retorno no puede ser antes del inicio")
    end
  end
end
