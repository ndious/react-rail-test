class Contract < ApplicationRecord

  has_and_belongs_to_many :users
  has_and_belongs_to_many :options

  validates :start_at, presence: true

  validate :validate_uniqueness_of_user_options, on: :create

  validates_presence_of :users
  validates_presence_of :options

  after_create_commit :set_default_values

  # On save update the status of the contract
  before_save :update_status

  # Checks if end_at is in the future and if is after start_at
  validates :end_at, comparison: { greater_than: :start_at }, allow_nil: true
  
  enum status: [:pending, :active, :finished]

  # Scopes

  # Finds all contracts with the start_date in the past and end_date in the future and status not active
  scope :not_activated_need_to_be_updated, 
          -> { where('start_at < ? AND end_at > ? AND status != ?', Time.now, Time.now, :active) }

  # Finds all contracts with the end_date in the past and status not finished
  scope :not_finished_need_to_be_updated, 
          -> { where('end_at < ? AND status != ?', Time.now, :finished) }

  # Finds all contracts with the start_date in the future and status not pending
  scope :not_pending_need_to_be_updated,
          -> { where('start_at > ? AND status != ?', Time.now, :pending) }

  # Finds all contracts not deleted
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Finds all contracts deleted
  scope :deleted, -> { where.not(deleted_at: nil) }

  private
    # Compute the status of the contract
    def update_status
      if end_at? && end_at < Time.now
        self.status = :finished
      elsif start_at < Time.now
        self.status = :active
      else
        self.status = :pending
      end
    end

    def validate_uniqueness_of_user_options
      users.each do |user|
        user.contracts.not_deleted.each do |contract|
          options.each do |option|
            if contract.options.include? option
              errors.add(:base, "User #{user.email} already has option #{option.identifier}")
            end
          end
        end
      end
    end

    def set_default_values
      self.number = "C-%09d" % id
      unless end_at
        self.end_at = start_at + 30.years
      end
      self.save
    end
end
