module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :tag_relations, as: :taggable
    has_many :tags, through: :tag_relations
  end


  def tag_with(tag)
    tags << Tag.find_or_create_by(value: tag)
    self.save
  end


end
