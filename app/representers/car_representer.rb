class CarRepresenter
  def initialize(car)
    @car = car
  end

  def as_json
    {
      id: @car.id,
      model: @car.model,
      photo: @car.photo,
      description: @car.description,
      cost: @car.cost
    }
  end

  private

  attr_reader :user
end
