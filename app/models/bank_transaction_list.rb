require 'csv'
class BankTransactionList < ApplicationRecord
  has_one_attached :source_file
  has_many :bank_transactions, dependent: :destroy

  after_commit :enqueue_load_from_source_file, on: :create

  def enqueue_load_from_source_file
    AnalyzeBankTransactionListJob.perform_later(self)
  end

  def load_from_source_file
    source_file.open do |file|
      CSV.new(file.read).map do |line|
        bank_transactions << BankTransaction.new(description: line[4], total: line[1], posted_at: line[0])   
      end
    end
    self.save
    bank_transactions
  end
end
