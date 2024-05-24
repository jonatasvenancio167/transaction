class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.float :balance

      t.timestamps
    end
  end
end
