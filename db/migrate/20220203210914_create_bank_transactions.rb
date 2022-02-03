class CreateBankTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_transactions do |t|
      t.date :posted_at
      t.integer :amount
      t.string :description
      t.string :md5

      t.timestamps
    end
  end
end
