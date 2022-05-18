class Contract < ApplicationRecord
  has_many :contract_clients
  has_many :users, through: :contract_clients

  belongs_to :contract_option

  validates :start_at, presence: true
  validates :contract_clients, presence: true
  validates :contract_option, presence: true

  enum :status, [:pending, :active, :finished]
end
