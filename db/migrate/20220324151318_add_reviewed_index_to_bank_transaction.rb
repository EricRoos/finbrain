class AddReviewedIndexToBankTransaction < ActiveRecord::Migration[7.1]
  def change
    add_index :bank_transactions, :reviewed
  end
end
