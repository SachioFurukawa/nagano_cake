class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  attachment :image

 def self.search(search)
     if search
       where(['username LIKE ?', "%#{search}%"])
     else
       all
     end
 end

 before_save :add_tax_price

 def add_tax_price
     (self.price * 1.1).round
 end

  with_options presence: true do
		  validates :genre_id
		  validates :name
		  validates :introduction
		  validates :price
	end

end
