class Address < ApplicationRecord
  belongs_to :user

    def view_address
        "#{self.postal_code} #{self.address} #{self.name}"
    end

    with_options presence: true do
		  validates :user_id
		  validates :name
		  validates :postal_code
		  validates :address
	  end

end
