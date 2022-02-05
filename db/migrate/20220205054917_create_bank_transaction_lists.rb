class CreateBankTransactionLists < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_transaction_lists do |t|

      t.timestamps
    end
  end
end
