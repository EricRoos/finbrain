class AddScoretoSimilarityMatch < ActiveRecord::Migration[7.1]
  def change
    add_column :similarity_matches, :score, :float
  end
end
