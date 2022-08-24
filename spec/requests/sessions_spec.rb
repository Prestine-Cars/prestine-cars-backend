require 'swagger_helper'

RSpec.describe 'sessions', type: :request do

   path '/users/sign_in' do
    post('sign-in') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :users, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      response(200, 'successful') do
        let(:user) { { email: 'ben@gmail.com', password: '123456' } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Incorrect email/password') do
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
