require 'rails_helper'

RSpec.describe 'Cities', type: :request do
  let(:user) { User.create!(name: 'Amira', email: 'amira@gmail.com', password: '123456') }
  let(:valid_attributes) do
    {
      name: 'Berlin',
      flag_icon: 'www.example/germany.png',
      description: 'City in Germany',
      user_id: user.id
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      flag_icon: '',
      description: '',
      user_id: ''
    }
  end

  describe 'GET /index' do
    it 'returns a list of cities' do
      get '/api/v1/cities', headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    it 'returns a city' do
      city = City.create!(valid_attributes)
      get "/api/v1/cities/#{city.id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
      expect(response).to have_http_status(200)
      json_body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json_body).to match(
        'id' => city.id,
        'name' => city.name,
        'flag_icon' => city.flag_icon,
        'description' => city.description,
        'cars' => []
      )
    end

    it 'returns a city with a relevant resource' do
      city = City.create!(valid_attributes)
      car = Car.create!(model: 'Mercedes', photo: 'www.example/mercedez.png', description: 'This a german car',
                        cost: 100, user_id: user.id, city_id: city.id)
      get "/api/v1/cities/#{city.id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
      expect(response).to have_http_status(200)
      json_body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json_body).to match(
        'id' => city.id,
        'name' => city.name,
        'flag_icon' => city.flag_icon,
        'description' => city.description,
        'cars' => [{
          'id' => car.id,
          'model' => car.model,
          'photo' => car.photo,
          'description' => car.description,
          'cost' => car.cost.to_s,
          'city' => city.name,
          'city_id' => city.id,
          'reservations' => car.reservations.count
        }]
      )
    end

    it 'returns a not found message' do
      get '/api/v1/cities/1', headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new city' do
        expect do
          post '/api/v1/cities', params: { city: valid_attributes },
                                 headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
        end.to change(City, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'creates a new city' do
        expect do
          post '/api/v1/cities', params: { city: invalid_attributes },
                                 headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
        end.to change(City, :count).by(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested city' do
      city = City.create!(valid_attributes)
      expect do
        delete "/api/v1/cities/#{city.id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
      end.to change(City, :count).by(-1)
    end
  end
end
