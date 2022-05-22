class AddIndexToContractRelations < ActiveRecord::Migration[7.0]
  def change
    add_index :contracts_users, [:contract_id, :user_id], unique: true
    add_index :contracts_options, [:contract_id, :option_id], unique: true    
  end
end
