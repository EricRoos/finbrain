class AddAnalyzedAtToBankTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :bank_transactions, :analyzed_at, :datetime
  end
end
