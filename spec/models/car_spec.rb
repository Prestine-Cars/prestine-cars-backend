require 'rails_helper'

RSpec.describe Car, type: :model do
  before(:each) do
    @user = User.create(name: 'Ben', email: 'ben@gmail.com', password: '123456')
    @city = City.create(name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany', user: @user)
    @car =  Car.create(model: 'Mercedes', photo: 'www.example/mercedez.png', description: 'This a german car', cost: 100, user: @user, city: @city)
  end

  it 'is valid with valid attribute' do
    expect(@car).to be_valid
  end

  it 'is not valid without a model' do
    @car.model = nil
    expect(@car).to_not be_valid
  end

  it 'is not valid without a photo' do
    @car.photo = nil
    expect(@car).to_not be_valid
  end

  it 'is not valid without a cost' do
    @car.cost = nil
    expect(@car).to_not be_valid
  end

  it 'is not valid with a model longer than 50 characters' do
    @car.model = 'a' * 51
    expect(@car).to_not be_valid
  end

  it 'is not valid with a model shorter than 3 characters' do
    @car.model = 'a' * 2
    expect(@car).to_not be_valid
  end

  it 'is not valid without a user' do
    @car.user = nil
    expect(@car).to_not be_valid
  end

  it 'is not valid without a city' do
    @car.city = nil
    expect(@car).to_not be_valid
  end
end
