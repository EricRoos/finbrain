class CreateSimilarityMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :similarity_matches do |t|
      t.references :source, null: false, foreign_key: { to_table: :bank_transactions }
      t.references :destination, null: false, foreign_key: { to_table: :bank_transactions }

      t.timestamps
    end
  end
end
