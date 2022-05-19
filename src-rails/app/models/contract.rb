class Contract < ApplicationRecord
  has_many :contract_clients
  has_many :users, through: :contract_clients

  has_many :contract_options
  has_many :options, through: :contract_options

  validates :start_at, presence: true
  validates :contract_clients, presence: true
  validates :contract_options, presence: true

  enum status: [:pending, :active, :finished]
end
