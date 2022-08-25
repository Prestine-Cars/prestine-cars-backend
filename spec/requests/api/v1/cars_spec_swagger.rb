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
  end
end