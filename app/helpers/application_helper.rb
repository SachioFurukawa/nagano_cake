module ApplicationHelper

  def money_notation(price)
    price.round.to_s(:delimited)
  end

  def integer_string?(str)
    Integer(str)
      true
  rescue ArgumentError
      false
  end

end
