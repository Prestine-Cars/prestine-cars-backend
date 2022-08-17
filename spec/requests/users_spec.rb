require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      name: 'Benten',
      email: 'benten@gmail.com',
      password: '123456'
    }
  end
  let(:invalid_attributes) do
    {
      name: 'Benten',
      email: '',
      password: '123456'
    }
  end

  let(:valid_login_attributes) do
    {
      email: 'benten@gmail.com',
      password: '123456'
    }
  end

  describe 'POST /users' do
    context 'with valid attributes' do
      it 'authenticates the user' do
        post user_registration_path, params: { user: valid_attributes }
        json_body = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json_body).to match(
          {
            'id' => User.last.id,
            'name' => 'Benten',
            'token' => AuthenticationTokenService.call(User.last.id)
          }
        )
      end
    end

    context 'with invalid attributes' do
      it 'renders an error message' do
        post user_registration_path, params: { user: invalid_attributes }
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'POST /users/sign_in' do
    context 'with valid sign in attributes' do
      it 'Signs in the user' do
        post '/users/sign_in', params: { session: valid_login_attributes }
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
