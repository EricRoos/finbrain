module TagManager
  def self.replace_tag_with(original_tag_val, new_tag_val)
    original_tag = Tag.where(value: original_tag_val).first
    return unless original_tag.present?
    new_tag = Tag.where(value: new_tag_val).first
    new_tag = Tag.create(value: new_tag_val) if new_tag.nil?
    if new_tag.persisted?
      original_tag.tag_relations.update_all(tag_id: new_tag.id)
      original_tag.destroy
    end
  end

  def self.add_associated_tag(first_tag, associated_tag)
    tag = Tag.where(value: first_tag).first

    new_tag = Tag.where(value: associated_tag).first
    new_tag = Tag.create(value: associated_tag) if new_tag.nil?

    new_tag_relations = tag.tag_relations.map do |tag_relation|
      { taggable_type: tag_relation.taggable_type, taggable_id: tag_relation.taggable_id, tag_id: new_tag.id }
    end
    TagRelation.insert_all new_tag_relations
  end
end
