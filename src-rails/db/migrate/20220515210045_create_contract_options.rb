class CreateContractOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_options do |t|
      t.references :option, index: true, foreign_key: true
      t.references :contract, index: true, foreign_key: true

      t.timestamps
    end
  end
end
