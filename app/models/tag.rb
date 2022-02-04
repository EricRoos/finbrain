class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  validates :value, uniqueness: true

  def self.recent_tags(limit=5)
    Tag.joins(:tag_relations).order("tag_relations.created_at": :desc).limit(limit*5).pluck(:value).uniq
  end
end
