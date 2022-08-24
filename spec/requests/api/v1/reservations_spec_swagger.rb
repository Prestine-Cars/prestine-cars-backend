require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do

  path '/api/v1/cities/{city_id}/cars/{car_id}/reservations' do
    # You'll want to customize the parameter types...
    parameter name: 'city_id', in: :path, type: :string, description: 'city_id'
    parameter name: 'car_id', in: :path, type: :string, description: 'car_id'

    get('list reservations') do
      response(200, 'successful') do
        let(:city_id) { '123' }
        let(:car_id) { '123' }

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

    post('create reservation') do
      response(200, 'successful') do
        let(:city_id) { '123' }
        let(:car_id) { '123' }

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

  path '/api/v1/cities/{city_id}/cars/{car_id}/reservations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'city_id', in: :path, type: :string, description: 'city_id'
    parameter name: 'car_id', in: :path, type: :string, description: 'car_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete reservation') do
      response(200, 'successful') do
        let(:city_id) { '123' }
        let(:car_id) { '123' }
        let(:id) { '123' }

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
