class BankTransaction < ApplicationRecord
  include Taggable

  before_save :compute_md5

  private

  def compute_md5
    self.md5 = Digest::MD5.hexdigest(md5_attrs.join("#"))
  end

end
