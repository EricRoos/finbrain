class BankTransactionDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def posted_at
    object.posted_at.strftime("%m/%d/%Y")
  end

  def total
    object.total.format
  end

  def reviewed
    object.reviewed ? 'Yes' : 'No'
  end

end
