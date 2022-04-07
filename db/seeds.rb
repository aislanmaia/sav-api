# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'admin', firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: 'admin@admin.com', password: "123456", role: 1, registry: 111)
User.create(username: 'attendant1', firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: 'atendente1@email.com', password: "123456", role: 2, registry: 222)
technician1 = User.create(username: 'technician1', firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: 'tecnico1@email.com', password: "123456", role: 3, registry: 333)
technician2 = User.create(username: 'technician2', firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: 'tecnico2@email.com', password: "123456", role: 3, registry: 444)

c1 = Client.create(name: 'Carolyn T. Moore', email: 'carolyntmoore@jourrapide.com', phone: '67986453199', address: {
  street: 'Rua A',
  neighborhood: 'Centro',
  number: '123',
  city: 'Sao Paulo',
  uf: 'SP'
})

c2 = Client.create(name: 'Leonardo Carvalho Melo', email: 'leonardo@transpil.com', phone: '3149735913', address: {
  street: 'José Correa',
  neighborhood: 'Centro',
  number: '1296',
  city: 'Santa Luzia',
  uf: 'MG'
})

c3 = Client.create(name: 'Júlio Souza Martins', email: 'juliosouzamartins@lodash.com', phone: '45986641584', address: {
  street: 'Landulfo Alves',
  neighborhood: 'Centro',
  number: '1721',
  city: 'Landulfo Alves',
  uf: 'BA'
})

c4 = Client.create(name: 'Isabella Azevedo Fernandes', email: 'isabellaazevedofernandes@rhyta.com', phone: '1678055309', address: {
  street: 'Coronel Mariano de Melo',
  neighborhood: 'Centro',
  number: '1571',
  city: 'Ribeirão Preto',
  uf: 'SP'
})

Schedule.create(client_id: c1.id, user: technician1, scheduling_date: DateTime.new(2022, 3, 30, 8, 0, 0), status: :open)
Schedule.create(client_id: c2.id, user: technician1, scheduling_date: DateTime.new(2022, 3, 30, 9, 0, 0), status: :open)
Schedule.create(client_id: c3.id, user: technician2, scheduling_date: DateTime.new(2022, 3, 30, 8, 0, 0), status: :open)
Schedule.create(client_id: c4.id, user: technician2, scheduling_date: DateTime.new(2022, 3, 30, 9, 0, 0), status: :open)
