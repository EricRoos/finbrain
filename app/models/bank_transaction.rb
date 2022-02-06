class BankTransaction < ApplicationRecord
  include Taggable

  monetize :total_cents

  validates_presence_of :posted_at, :description, :total
  validates_uniqueness_of :md5
  before_validation :compute_md5

  after_commit :enqueue_analyze_description, on: :create

  def enqueue_analyze_description
    AnalyzeBankTransactionJob.perform_later(self)
  end

  def self.load_from_csv(csv_path)
  end

  def analyze_description
    nlp_conn = Faraday.new(url: 'http://localhost:9000')
    response = nlp_conn.post('/?properties={"annotators":"ner","outputFormat":"json"}') do |req|
      req.body = description
    end
    resp = JSON.parse(response.body)
    self.analyzed_tokens = resp["sentences"].map { |s| 
      puts s["tokens"] if ENV['DEBUG_NLP'].present?
      s["tokens"].select { |t|
        t["pos"] == 'NNP'  && (
          t["ner"] == 'STATE_OR_PROVINCE' || 
          t["ner"] == 'CITY' || 
          t["ner"] == 'LOCATION' || 
          t["ner"] == 'ORGANIZATION' || 
          t["ner"] == 'URL' || 
          t["ner"] == 'O'
        )
      }.map{ |i|
        i["lemma"]
      }
    }.flatten.map(&:downcase)
    self.save
  end
  private

  def compute_md5
    md5_attrs = [ posted_at.to_s, description, amount.to_s ]
    self.md5 = Digest::MD5.hexdigest(md5_attrs.join("#"))
  end

end
