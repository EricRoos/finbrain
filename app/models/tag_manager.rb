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

end
