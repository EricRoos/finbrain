require 'csv'
class BankTransactionList < ApplicationRecord
  has_one_attached :source_file
  has_many :bank_transactions

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
