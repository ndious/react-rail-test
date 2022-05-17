class AddContractOptionsToContracts < ActiveRecord::Migration[7.0]
  def change
    add_reference :contracts, :contract_option, null: false, foreign_key: true
  end
end
