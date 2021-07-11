module Public::OrdersHelper

  def amount(order_items)
    order_items.map{ |op| op.subtotal }.sum
  end

end
