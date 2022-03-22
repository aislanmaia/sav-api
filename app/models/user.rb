class User < ApplicationRecord
  has_secure_password

  ROLES = { admin: 1, attendant: 2, technicion: 3 }.freeze
end
