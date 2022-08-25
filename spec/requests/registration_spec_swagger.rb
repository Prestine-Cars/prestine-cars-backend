require 'swagger_helper'

RSpec.describe 'registration', type: :request do
  path '/users' do
    post('sign-up') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :users, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      response(200, 'successful') do
        let(:users) { { name: 'Ben', email: 'ben@gmail.com', password: '123456' } }
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

  path '/users' do
    post('sign-up') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :users, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(422, 'Name/Email already exists') do
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
