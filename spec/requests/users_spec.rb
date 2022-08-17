require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      name: 'Benten',
      email: 'ben@gmail.com',
      password: '123456'
    }
  end
  let(:invalid_attributes) do
    {
      name: 'Ben',
      email: '',
      password: '123456'
    }
  end

  describe 'POST /users' do
    context 'with valid attributes' do
      it 'authenticates the user' do
        post user_registration_path, params: { user: valid_attributes  }
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
  end
end
