require 'rails_helper'

RSpec.describe Car, type: :model do
  before(:each) do
    @user = User.create(name: 'Ben', email: 'ben@gmail.com', password: '123456')
    @city = City.create(name: 'Berlin', flag_icon: 'www.example/germany.png', description: 'City in Germany',
                        user: @user)
    @car = Car.create(model: 'Mercedes', photo: 'www.example/mercedez.png', description: 'This a german car',
                      cost: 100, user: @user, city: @city)
    @reservation = Reservation.create(user: @user, car: @car, date: Time.now.utc.to_date)
  end

  it 'is valid with date user and car' do
    expect(@reservation).to be_valid
  end

  it 'is not valid without a car' do
    @reservation.car = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a user' do
    @reservation.user = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a date' do
    @reservation.date = nil
    expect(@reservation).to_not be_valid
  end
end
