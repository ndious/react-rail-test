class CreateJoinTableContractsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :contracts, :users do |t|
      # t.index [:contract_id, :user_id]
      # t.index [:user_id, :contract_id]
    end
  end
end
