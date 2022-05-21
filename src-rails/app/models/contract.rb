class Contract < ApplicationRecord
  has_many :contract_clients
  has_many :users, through: :contract_clients

  has_many :contract_options
  has_many :options, through: :contract_options

  validates :start_at, presence: true
  validates :contract_clients, presence: true
  validates :contract_options, presence: true

  enum status: [:pending, :active, :finished]

  # Finds all contracts not deleted
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Finds all contracts deleted
  scope :deleted, -> { where.not(deleted_at: nil) }
end
