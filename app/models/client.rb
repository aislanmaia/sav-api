class Client < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :schedule
end
