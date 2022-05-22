class CreateJoinTableContractsOptions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :contracts, :options do |t|
      # t.index [:contract_id, :option_id]
      # t.index [:option_id, :contract_id]
    end
  end
end
