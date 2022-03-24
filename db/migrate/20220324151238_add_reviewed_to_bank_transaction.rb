class AddReviewedToBankTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :bank_transactions, :reviewed, :boolean, default: false
  end
end
