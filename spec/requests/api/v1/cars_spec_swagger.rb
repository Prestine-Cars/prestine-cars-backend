require 'swagger_helper'
RSpec.describe 'api/v1/cars', type: :request do
  path '/api/v1/cities/{city_id}/' do
    parameter name: 'city_id', in: :path, type: :integer, description: 'City id'
    get('List of cars of a particular city') do
      tags 'City cars'
      security [bearerAuth: {}]
      response(200, 'Successful') do
        let(:id) { '1' }
        let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(401, 'Not authorized') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
    post('add a car for a city') do
      tags 'City cars'
      security [bearerAuth: {}]
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: 
        {
      model:  { type: :string },
      photo:  { type: :string },
      description:  { type: :string },
      cost:  { type: :integer },
      user_id:  { type: :integer },
      city_id: { type: :integer }
    },
        required: %w[model photo cost user_id city_id]
      }
      response(201, 'Created') do
        let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
         let(:city) { { name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany' } }
        let(:car){ { model: 'Mercedes', photo: 'www.example/mercedez.png', description: 'This a german car',
                      cost: 100, user_id: 1, city_id: 1} }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(400, 'Bad Request') do
        let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
         let(:city) { { name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany' } }
        let(:car){ { photo: 'www.example/mercedez.png', description: 'This a german car',
                      cost: 100, user_id: 1, city_id: 1} }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(401, 'Not authorized') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end