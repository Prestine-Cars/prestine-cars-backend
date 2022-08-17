class CityRepresenter
  def initialize(city)
    @city = city
  end

  def as_json
    {
      id: city.id,
      name: city.name,
      description: city.description,
      flag_icon: city.flag_icon,
      cars: city.cars.map { |car| CarRepresenter.new(car).as_json }
    }
  end

  private

  attr_reader :city
end
