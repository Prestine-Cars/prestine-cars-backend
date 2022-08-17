require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    let(:user) { User.create(name: 'Selma', email: 'selma@gmail.com', password: 'selma123456') }
    let(:car) do
      Car.create(name: 'Test Car', description: 'Affortable car', city: 'Capital of Algeria', price: '1000',
                 icon: 'photo.png')
    end
    subject { described_class.new(date: '2020-9-8', city: 'Capital of Algeria', user:, car:) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'that reservation belongs to user and car' do
      subject.save
      expect(user.reservations).to eq([subject])
      expect(car.reservations).to eq([subject])
      subject.destroy
    end

    it 'is not valid without a date' do
      subject.date = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a city' do
      subject.city = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a car_id' do
      subject.car_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user_id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a car' do
      subject.car = nil
      expect(subject).to_not be_valid
    end
  end
end
