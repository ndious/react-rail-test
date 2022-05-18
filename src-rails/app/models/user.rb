class User < ApplicationRecord
  require "securerandom"

  has_secure_password

  has_many :contrat_clients
  has_many :contracts, through: :contrat_clients

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  enum :role, [:client, :admin]
end
