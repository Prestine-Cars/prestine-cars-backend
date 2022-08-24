require 'rails_helper'

RSpec.describe 'Cars', type: :request do
  before do
    load 'db/seeds.rb'
    @user = User.first
    @city= City.first
  end

  let(:valid_attributes) do
    {
      model: 'Mercedes',
      photo: 'www.example/mercedez.png',
      description: 'This a german car',
      cost: 100,
      user_id: @user.id,
      city_id: @city.id
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
          post api_v1_city_cars_path((@city)), params: { car: valid_attributes },
                          headers: { 'Authorization' => AuthenticationTokenService.call(@user.id) }
        end.to change(Car, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Car' do
        expect do
          post api_v1_city_cars_path(@city), params: { car: invalid_attributes },
                          headers: { 'Authorization' => AuthenticationTokenService.call(@user.id) }
        end.to change(Car, :count).by(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested deal' do
      @car = Car.create!(valid_attributes)
      expect do
        delete api_v1_city_car_url(@city, @car), headers: { 'Authorization' => AuthenticationTokenService.call(@user.id) }
      end.to change(Car, :count).by(-1)
    end
  end
end
