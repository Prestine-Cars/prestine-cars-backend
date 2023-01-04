class ReservationRepresenter
  def initialize(reservations)
    @reservations = reservations
  end

  def as_json
    reservations.map do |reservation|
      {
        id: reservation.id,
        date: reservation.date,
        car: CarRepresenter.new(reservation.car).as_json
      }
    end
  end

  private

  attr_reader :reservations
end
