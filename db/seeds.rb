# Application seed data

users = User.create!([
  {
    name: 'Ben',
    email: 'ben@gmail.com',
    password: '123456'
  },
  {
    name: 'Selma',
    email: 'selma@gmail.com',
    password: '123456'
  },
  {
    name: 'Sirri',
    email: 'sirri@gmail.com',
    password: '123456'
  },
])

cities = City.create!([
  {
    name: 'Nairobi',
    description: 'Nairobi is the capital of Kenya and the largest city in the country.',
    flag_icon: 'https:example.com',
    user: users.first,
  },
  {
    name: 'Kigali',
    description: 'Kigali is the capital of Rwanda and the largest city in the country.',
    flag_icon: 'https:example.com',
    user: users.second,
  },
  {
    name: 'Algiers',
    description: 'Algiers is the capital of Algeria and the largest city in the country.',
    flag_icon: 'https:example.com',
    user: users.first,
  }
])

cars = Car.create!([
  {
    model: 'Mercedes',
    description: 'German car',
    photo: 'https:example.com',
    cost: 24,
    city: cities.first,
    user: users.first,
  }
])

reservations = Reservation.create!([
  {
    user: users.first,
    car: cars.first,
    date: Time.now.utc.to_date,
  }
])
