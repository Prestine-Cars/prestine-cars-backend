require 'swagger_helper'

RSpec.describe 'api/v1/cities', type: :request do
  path '/api/v1/cities' do
    get('list cities') do
      tags 'Cities'
      produces 'application/json'
      response(200, 'successful') do
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

    post('create city') do
      tags 'Cities'
      security [bearerAuth: {}]
      consumes 'application/json'
      parameter name: :city, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          flag_icon: { type: :string }
        },
        required: %w[name description flag_icon]
      }
      response(201, 'successful') do
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
      response(400, 'Bad Request') do
        let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
        let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
        let(:city) { { name: 'Berlin', flag_icon: 'www.example/germany.png', description: '' } }
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
    end
  end
  path '/api/v1/cities/{id}' do
    parameter name: 'city_id', in: :path, type: :string, description: 'City id'
    get('show city') do
      tags 'City'
      produces 'application/json'
      response(200, 'successful') do
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
    end
    delete('delete city') do
      response(200, 'successful') do
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
    end
    response(404, 'Record not found') do
      let(:user) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
      let(:Authorization) { "Bearer #{AuthenticationTokenService.call(user.id)}" }
      let(:city_id) { '20' }
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
