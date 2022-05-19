class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts do |t|
      t.string :number
      t.integer :status
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
