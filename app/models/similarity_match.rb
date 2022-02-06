class SimilarityMatch < ApplicationRecord
  belongs_to :source, class_name: 'BankTransaction'
  belongs_to :destination, class_name: 'BankTransaction'

  validates_uniqueness_of :source, scope: :destination

  before_validation :calculate_score

  def calculate_score
    source_str = source.analyzed_tokens.sort.join(" ")
    destination_str = destination.analyzed_tokens.sort.join(" ")
    self.score = String::Similarity.cosine(source_str, destination_str)
  end
end
