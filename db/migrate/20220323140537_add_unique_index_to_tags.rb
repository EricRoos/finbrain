class AddUniqueIndexToTags < ActiveRecord::Migration[7.1]
  def change
    add_index :tags, [:value], unique: true
  end
end
