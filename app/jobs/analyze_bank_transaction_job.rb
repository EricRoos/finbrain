class AnalyzeBankTransactionJob < ApplicationJob
  queue_as :default

  def perform(bank_transaction)
    bank_transaction.analyze_description
    bank_transaction.analyzed_tokens.each do |token|
      bank_transaction.tag_with(token)
    end
  end
end
