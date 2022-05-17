class CreateContractClients < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_clients do |t|
      t.references :user, index: true, foreign_key: true
      t.references :contract, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
