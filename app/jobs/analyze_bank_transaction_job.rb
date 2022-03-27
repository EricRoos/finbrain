class AnalyzeBankTransactionJob < ApplicationJob
  queue_as :default

  def perform(bank_transaction)
    bank_transaction.analyze_description
    bank_transaction.analyzed_tokens.each do |token|
      bank_transaction.tag_with(token)
    end

    matches = []
    BankTransaction.find_in_batches(batch_size: 20_000) do |group|
      group.each do |b|
        s = SimilarityMatch.new(source: b, destination: bank_transaction)
        s.calculate_score
        if s.source && s.destination
          matches << s.as_json.slice("source_id", "destination_id", "score")
        end
      end
    end
    SimilarityMatch.insert_all matches
  end
end
