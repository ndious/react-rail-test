class CreateContractOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_options do |t|
      t.string :identifier
      t.string :description

      t.timestamps
    end
  end
end
