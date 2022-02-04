module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :tag_relations, as: :taggable
    has_many :tags, through: :tag_relations
  end


  def tag_with(tag_str)
    tag = Tag.find_or_create_by(value: tag_str)
    self.tags << tag unless tag_relations.where(tag: tag).exists?
    self.save
  end


end
