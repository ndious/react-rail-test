class User < ApplicationRecord
  require "securerandom"

  has_secure_password

  has_and_belongs_to_many :contracts

  validates :email, presence: true
  validates :email, uniqueness: true, on: :create
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :role, presence: true
  
  enum role: { client: 0, admin: 1 }
end
