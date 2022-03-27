class SimilarityMatch < ApplicationRecord
  belongs_to :source, class_name: 'BankTransaction'
  belongs_to :destination, class_name: 'BankTransaction'

  validates_uniqueness_of :source, scope: :destination

  before_validation :calculate_score

  def calculate_score
    source_str = source.description.gsub(/[A-Z]\d+ CARD \d{4}/, '').strip
    destination_str = destination.description.gsub(/[A-Z]\d+ CARD \d{4}/, '').strip
    self.score = String::Similarity.cosine(source_str, destination_str)
  end
end
