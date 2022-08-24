require 'swagger_helper'

RSpec.describe 'api/v1/cars', type: :request do
  path '/api/v1/cities/{city_id}/cars' do
    # You'll want to customize the parameter types...
    parameter name: 'city_id', in: :path, type: :string, description: 'city_id'

    post('create car') do
      response(200, 'successful') do
        let(:city_id) { '123' }

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

  path '/api/v1/cities/{city_id}/cars/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'city_id', in: :path, type: :string, description: 'city_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete car') do
      response(200, 'successful') do
        let(:city_id) { '123' }
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
