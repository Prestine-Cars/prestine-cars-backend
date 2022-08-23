# Application seed data

users = User.create!([
  {
    name: 'Benten',
    email: 'benten@gmail.com',
    password: '123456',
    role: "admin",
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
    flag_icon: 'https://res.cloudinary.com/optprime/image/upload/v1661257848/Prestine%20Cars/kenya-162332_p1mc5i.png',
    user: users.first,
  },
  {
    name: 'Kigali',
    description: 'Kigali is the capital of Rwanda and the largest city in the country.',
    flag_icon: 'https://res.cloudinary.com/optprime/image/upload/v1661258811/Prestine%20Cars/rwanda-26944_wprn08.png',
    user: users.second,
  },
  {
    name: 'Algiers',
    description: 'Algiers is the capital of Algeria and the largest city in the country.',
    flag_icon: 'https://res.cloudinary.com/optprime/image/upload/v1661258811/Prestine%20Cars/algeria-161961_vsxm3c.png',
    user: users.first,
  }
])

cars = Car.create!([
  {
    model: 'Mercedes',
    description: 'German car',
    photo: 'https://res.cloudinary.com/optprime/image/upload/w_1000,ar_16:9,c_fill,g_auto,e_sharpen/v1661251946/Prestine%20Cars/martin-katler-y3neNkE6efI-unsplash_axq2kh.jpg',
    cost: 24,
    city: cities.first,
    user: users.first,
  },
  {
    model: 'Toyota',
    description: 'Japenese car',
    photo: 'https://res.cloudinary.com/optprime/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1661251944/Prestine%20Cars/bestami-sarikaya-DwNmXuRb1Tk-unsplash_bmjwtm.jpg',
    cost: 10,
    city: cities.first,
    user: users.first,
  }
])

reservations = Reservation.create!([
  {
    user: users.first,
    car: cars.first,
    date: Time.now.utc.to_date,
  },
  {
    user: users.first,
    car: cars.second,
    date: Time.now.utc.to_date,
  }
])
