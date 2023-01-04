class CarRepresenter
  def initialize(car)
    @car = car
  end

  def as_json
    {
      id: car.id,
      model: car.model,
      photo: car.photo,
      description: car.description,
      cost: car.cost,
      city: car.city.name,
      city_id: car.city.id,
      reservations: car.reservations.count
    }
  end

  private

  attr_reader :car
end
