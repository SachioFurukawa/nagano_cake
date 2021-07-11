module AdminOther::OrderDetailsHelper

  def money_notation(price)
    price.round.to_s(:delimited)
  end

end
