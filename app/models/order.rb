class Order < ApplicationRecord

  attr_accessor :radio_button_number, :address_id

  belongs_to :user
  has_many :order_details, dependent: :destroy

  enum payment_method: { クレジットカード: 1, 銀行振り込み: 2 }
  enum status: { 入金待ち: 1, 支払い済み: 2, 製作中: 3, 発送準備中: 4, 発送完了: 5 }

  with_options presence: true do
		  validates :user_id
		  validates :name
		  validates :postal_code
		  validates :address
		  validates :payment_method
		  validates :total_charge
	end

end