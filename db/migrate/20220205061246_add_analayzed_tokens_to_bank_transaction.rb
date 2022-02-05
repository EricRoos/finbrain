class AddAnalayzedTokensToBankTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :bank_transactions, :analyzed_tokens, :text, array: true, default: []
  end
end
