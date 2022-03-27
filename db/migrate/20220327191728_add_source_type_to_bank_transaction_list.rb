class AddSourceTypeToBankTransactionList < ActiveRecord::Migration[7.1]
  def change
    add_column :bank_transaction_lists, :source_type, :string
  end
end
