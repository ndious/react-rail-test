class Contract < ApplicationRecord
  has_many :contract_clients
  has_many :users, through: :contract_clients

  has_many :contract_options
  has_many :options, through: :contract_options

  validates :start_at, presence: true

  validates :contract_clients, presence: true

  validates :contract_options, presence: true

  # On save update the status of the contract
  before_save :update_status

  # Checks if end_at is in the future and if is after start_at
  validates :end_at, presence: true, if: -> { end_at.present? }
  validate :end_at_after_start_at, if: -> { end_at > start_at }
  
  enum status: [:pending, :active, :finished]

  # Scopes

  # Finds all contracts with the start_date in the past and end_date in the future and status not active
  scope :not_activated_need_to_be_updated, 
          -> { where('start_at < ? AND end_at > ? AND status != ?', Time.now, Time.now, :active) }

  # Finds all contracts with the end_date in the past and status not finished
  scope :not_finished_need_to_be_updated, 
          -> { where('end_at < ? AND status != ?', Time.now, :finished) }

  # Finds all contracts with the start_date in the future and status not pending
  scope :not_pending_need_to_be_activated,
          -> { where('start_at > ? AND status != ?', Time.now, :pending) }

  # Finds all contracts not deleted
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Finds all contracts deleted
  scope :deleted, -> { where.not(deleted_at: nil) }

  private
    # Compute the status of the contract
    # if start_at is in the future, the contract is pending
    # if start_at is in the past, the contract is active
    # if end_at is in the future, the contract is finished
    def update_status
      if start_at > Time.now
        self.status = :pending
      elsif end_at > Time.now
        self.status = :active
      else
        self.status = :finished
      end
    end
end
