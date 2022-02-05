class AddBankTransactionListToBankTransaction < ActiveRecord::Migration[7.1]
  def change
    add_reference :bank_transactions, :bank_transaction_list, null: false, foreign_key: true
  end
end
