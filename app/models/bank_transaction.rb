class BankTransaction < ApplicationRecord
  include Taggable

  monetize :total_cents

  validates_presence_of :posted_at, :description, :total
  validates_uniqueness_of :md5
  has_many :similarity_matches, foreign_key: :source_id
  before_validation :compute_md5

  after_commit :enqueue_analyze_description, on: :create

  scope :reviewed, -> { where(reviewed: true) }
  scope :not_reviewed, -> { where(reviewed: false) }

  def enqueue_analyze_description
    AnalyzeBankTransactionJob.perform_later(self)
  end

  def self.load_from_csv(csv_path)
  end


  def analyze_description
    nlp_url = ENV.fetch('NLP_URL') { 'http://localhost:9000' }
    nlp_conn = Faraday.new(url: nlp_url)
    response = nlp_conn.post('/?properties={"annotators":"ner","outputFormat":"json"}') do |req|
      req.body = description.gsub(/PURCHASE AUTHORIZED ON/, '')
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
    }.flatten.map(&:downcase).map(&:strip)
    .reject { |r| r.size < 4 }
    .reject { |r| !r.match(/.*[a-z]+.*/) }
    .reject { |r| r.match(/[a-z]\d+/) }
    self.analyzed_at = DateTime.now
    self.save
  end

  private

  def compute_md5
    md5_attrs = [ posted_at.to_s, description, amount.to_s ]
    self.md5 = Digest::MD5.hexdigest(md5_attrs.join("#"))
  end

end
