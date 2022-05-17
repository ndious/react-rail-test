class ContractClient < ApplicationRecord
  has_many :contracts
  has_many :users
end
