class AnalyzeBankTransactionJob < ApplicationJob
  queue_as :default

  def perform(bank_transaction)
    bank_transaction.analyze_description
  end
end
