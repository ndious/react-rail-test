class Contract < ApplicationRecord
  has_many :contrat_clients
  has_many :users, through: :contrat_clients
  belongs_to :contract_option

  validates :start_at, presence: true
  validates :contract_clients, presence: true
  validates :contract_option, presence: true

  enum :status, [:pending, :active, :finished]
end
