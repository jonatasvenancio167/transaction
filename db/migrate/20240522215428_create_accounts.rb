class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :numero_conta
      t.float :saldo

      t.timestamps
    end
  end
end
