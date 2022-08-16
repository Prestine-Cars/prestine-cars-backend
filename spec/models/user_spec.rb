require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Ben', email: 'ben@mail.com', password: '123456') }

  context '.name' do
    it 'is not valid with a name less than 3 characters' do
      user.name = 'M'
      expect(user).to_not be_valid
    end

    it 'is valid with a name of more than 3 characters' do
      expect(user).to be_valid
    end
  end
end
