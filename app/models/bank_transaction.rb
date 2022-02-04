class BankTransaction < ApplicationRecord
  include Taggable

  monetize :total_cents

  validates_presence_of :posted_at, :description, :total
  before_save :compute_md5

  private

  def compute_md5
    md5_attrs = [ posted_at.to_s, description, amount.to_s ]
    self.md5 = Digest::MD5.hexdigest(md5_attrs.join("#"))
  end

end
