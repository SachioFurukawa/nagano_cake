class OrderDetail < ApplicationRecord

enum making_status: { disable: 1, wait: 2, working: 3, done: 4 }

  belongs_to :order
  belongs_to :item

  def subtotal
    self.amount * self.price
  end

end
