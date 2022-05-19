class Option < ApplicationRecord
  has_many :contract_options
  has_many :contracts, through: :contract_options
end
