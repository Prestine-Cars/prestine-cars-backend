require 'rails_helper'

RSpec.describe 'Cars', type: :request do
  let(:user) { User.create!(name: 'Amira', email: 'amira@gmail.com', password: '123456') }
  let(:city) do
    City.create!(name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany', user:)
  end

  let(:valid_attributes) do
    {
      model: 'Mercedes',
      photo: 'www.example/mercedez.png',
      description: 'This a german car',
      cost: 100,
      user_id: user.id,
      city_id: city.id
    }
  end

  let(:invalid_attributes) do
    {
      model: '',
      photo: '',
      description: '',
      cost: '',
      user: '',
      city: ''
    }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new car' do
        expect do
          post cars_path, params: { car: valid_attributes },
                          headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
        end.to change(Car, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Car' do
        expect do
          post cars_path, params: { car: invalid_attributes },
                          headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
        end.to change(Car, :count).by(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested deal' do
      car = Car.create!(valid_attributes)
      expect do
        delete car_path(car.id), headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
      end.to change(Car, :count).by(-1)
    end
  end
end
