class AnalyzeBankTransactionListJob < ApplicationJob
  queue_as :default

  def perform(bank_transaction_list)
    bank_transaction_list.load_from_source_file
  end
end
