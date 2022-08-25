require 'swagger_helper'

RSpec.describe 'api/v1/cities', type: :request do
  path '/api/v1/cities' do
    get('list cities') do
      tags 'Cities'
      response(200, 'Successful') do
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

    post('add a city') do
      tags 'City'
      security [bearerAuth: {}]
      consumes 'application/json'
      parameter name: :mentor, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          flag_icon: { type: :string }
        },
        required: %w[name description flag_icon]
      }
      response(201, 'Ok') do
        let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:city) { { name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany' } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, "Unprocessable Entity") do
        let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:city) { { name: 'Berlin', flag_icon: 'www.example/germany.png'} }
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

  path '/api/v1/cities/{city_id}' do
    parameter name: 'city_id', in: :path, type: :integer, description: 'City id'
    delete('delete a city') do
      tags 'Cities'
      security [bearerAuth: {}]
      response(204, 'City deleted') do
       let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:city_id) { '1' }
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

      response(404, 'Record not found') do
        let(:city_id) { '10' }
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
    end
  end

  path '/api/v1/cities/{city_id}' do
    parameter name: 'city_id', in: :path, type: :integer, description: 'City id'

    get('get a city') do
      tags 'city_id'
      response(200, 'Successful') do
         let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:city_id) { '1' }
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

      response(404, 'Record not found') do
       let(:city_id) { '10' }
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
    end
  end
end