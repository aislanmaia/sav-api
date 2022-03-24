class Client < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
