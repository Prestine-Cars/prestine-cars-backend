require 'rails_helper'

RSpec.describe City, type: :model do
  before(:each) do
    @user = User.create(name: 'Ben', email: 'ben@gmail.com', password: '123456')
    @city = City.create(name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany',
                        user: @user)
    @car = Car.create(model: 'Mercedes', photo: 'www.example/mercedez.png', description: 'This a german car',
                      cost: 100, user: @user, city: @city)
  end

  it 'is valid with valid attribute' do
    expect(@city).to be_valid
  end

  it 'is not valid without a name' do
    @city.name = nil
    expect(@city).to_not be_valid
  end

  it 'is not valid without a flag icon' do
    @city.flag_icon = nil
    expect(@city).to_not be_valid
  end

  it 'is not valid with a name longer than 50 characters' do
    @city.name = 'a' * 51
    expect(@city).to_not be_valid
  end

  it 'is not valid with a name shorter than 3 characters' do
    @city.name = 'a' * 2
    expect(@city).to_not be_valid
  end

  it 'is not valid without a user' do
    @city.user = nil
    expect(@city).to_not be_valid
  end
end
