# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'Admin', email: 'admin@admin.com', password: "123456", role: 1, registry: 999)
User.create(username: 'Atendente 1', email: 'atendente1@email.com', password: "123456", role: 2, registry: 888)

Client.create(name: 'Carolyn T. Moore', email: 'carolyntmoore@jourrapide.com', phone: '67986453199', address: {
  street: 'Rua A',
  neighborhood: 'Centro',
  number: '123',
  city: 'Sao Paulo',
  uf: 'SP'
})

Client.create(name: 'Leonardo Carvalho Melo', email: 'carolyntmoore@jourrapide.com', phone: '3149735913', address: {
  street: 'José Correa',
  neighborhood: 'Centro',
  number: '1296',
  city: 'Santa Luzia',
  uf: 'MG'
})

Client.create(name: 'Júlio Souza Martins', email: 'juliosouzamartins@lodash.com', phone: '45986641584', address: {
  street: 'Landulfo Alves',
  neighborhood: 'Centro',
  number: '1721',
  city: 'Landulfo Alves',
  uf: 'BA'
})

Client.create(name: 'Isabella Azevedo Fernandes', email: 'isabellaazevedofernandes@rhyta.com', phone: '1678055309', address: {
  street: 'Coronel Mariano de Melo',
  neighborhood: 'Centro',
  number: '1571',
  city: 'Ribeirão Preto',
  uf: 'SP'
})
