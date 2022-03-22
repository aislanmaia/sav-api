class User < ApplicationRecord
  has_secure_password

  ROLES = { admin: 1, attendant: 2, technicion: 3 }.freeze

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true
end
