class TagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates_uniqueness_of :taggable_id, scope: [ :tag_id, :taggable_type ]
end
