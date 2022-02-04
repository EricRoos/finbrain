class AddTotalToBankTransaction < ActiveRecord::Migration[7.1]
  def change
    add_monetize :bank_transactions, :total, currency: { present: false }
  end
end
