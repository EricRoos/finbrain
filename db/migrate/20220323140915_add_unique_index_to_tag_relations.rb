class AddUniqueIndexToTagRelations < ActiveRecord::Migration[7.1]
  def change
    add_index :tag_relations, [:taggable_type, :taggable_id, :tag_id], unique: true
  end
end
