require 'csv'
class BankTransactionList < ApplicationRecord
  has_one_attached :source_file
  has_many :bank_transactions, dependent: :destroy

  after_commit :enqueue_load_from_source_file, on: :create

  def enqueue_load_from_source_file
    AnalyzeBankTransactionListJob.perform_later(self)
  end

  def load_from_source_file
    has_headers = source_type == 'Amex' || source_type == 'Chase'
    source_file.open do |file|
      CSV.new(file.read, headers: has_headers).map do |line|
        if source_type == 'Wells Fargo'
          description = line[4]
          description.gsub!(/PURCHASE AUTHORIZED ON \d{1,2}\/\d{1,2}/,'')
          description.gsub!(/RECURRING PAYMENT AUTHORIZED ON \d{1,2}\/\d{1,2}/,'')
          bank_transactions << BankTransaction.new(description: description.strip, total: line[1], posted_at: Date.strptime(line[0], '%m/%d/%Y'))   
        elsif source_type == 'Amex'
          bank_transactions << BankTransaction.new(
            description: line[1], 
            total: -1 * line[2].to_f, 
            posted_at: Date.strptime(line[0], '%m/%d/%Y')
          )   
        elsif source_type == 'Chase'
          bank_transactions << BankTransaction.new(
            description: line[2], 
            total: line[5].to_f, 
            posted_at: Date.strptime(line[0], '%m/%d/%Y')
          )   
        end
      end
    end
    self.save
    bank_transactions
  end

end
