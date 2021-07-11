class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :cart_items, dependent: :destroy
 has_many :addresses, dependent: :destroy
 has_many :orders, dependent: :destroy

  with_options presence: true do
    validates :first_name
    validates :family_name
    validates :kana_first_name
    validates :kana_family_name
    validates :postal_code
    validates :address
    validates :phone_number
  end

  #def active_for_authentication?
    #super && (self.is_deleted == false)
  #end

  #def active?
    #!!is_deleted
  #end

   validates :is_deleted, inclusion:{in: [true, false]}

  def full_name
    family_name + first_name
  end

end
