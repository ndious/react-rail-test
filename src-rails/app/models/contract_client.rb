class ContractClient < ApplicationRecord
  belongs_to :contract
  belongs_to :user
end
