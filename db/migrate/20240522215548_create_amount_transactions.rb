class CreateAmountTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :amount_transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.float :amount
      t.string :transaction_type

      t.timestamps
    end
  end
end
