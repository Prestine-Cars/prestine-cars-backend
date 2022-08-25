require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  path 'api/v1/reservations' do
    get('list reservations') do
      tags 'Reservations'
      security [bearerAuth: {}]
      response(200, 'Successful') do
        let(:user) { { name: 'Ben', email: 'mailto:ben@gmail.com', password: '123456' } }
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

  path '/api/v1/cities/{city_id}/cars/{car_id}/reservations/' do
        post('create reservation') do
      tags 'Reservations'
      security [bearerAuth: {}]
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          car_id: { type: :integer },
          date: { type: :string }
        },
        required: %w[user_id car_id date]
      }

      response(201, 'successful') do
        let(:user) { { name: 'Ben', email: 'mailto:ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:reservation) { { user_id: 1, car_id: 1, date: '2022-01-01' } }
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
        let(:user) { { name: 'Ben', email: 'mailto:ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:reservation) { { user_id: 1, car_id: 1 } }
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

  path '/api/v1/cities/{city_id}/cars/{car_id}/reservations/{id}' do
    parameter name: 'city_id', in: :path, type: :integer, description: 'city_id'
    parameter name: 'car_id', in: :path, type: :integer, description: 'car_id'
    parameter name: 'reservation_id', in: :path, type: :integer, description: 'reservation_id'
    delete('delete reservation') do
      tags 'Reservations'
      security [bearerAuth: {}]
      response(204, 'Reservation canceled') do
        let(:id) { '1' }
         let(:user) { { name: 'Ben', email: 'mailto:ben@gmail.com', password: '123456' } }
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

      response(401, 'You will need to login first') do
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
        let(:id) { '123' }
         let(:user) { { name: 'Ben', email: 'mailto:ben@gmail.com', password: '123456' } }
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