class User < ApplicationRecord
  require "securerandom"

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  has_many :contrat_clients
  has_many :contracts, through: :contrat_clients

  enum :role, [:client, :admin]
end
