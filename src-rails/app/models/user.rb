class User < ApplicationRecord
  require "securerandom"

  has_secure_password

  has_many :contract_clients
  has_many :contracts, through: :contract_clients

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  enum role: { client: 0, admin: 1 }
end
