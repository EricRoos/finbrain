class ComputeSimilarityJob < ApplicationJob
  queue_as :default

  def perform(source, destination)
    self.class.perform_later(source,destination) and return unless source.analyzed_at.present? && destination.analyzed_at.present?
    SimilarityMatch.create(source: source, destination: destination)
  end
end
