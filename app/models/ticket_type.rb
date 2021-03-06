class TicketType < ActiveRecord::Base
  belongs_to :event
  validates :name, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0 }
  validates :max_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :check_duplicates
 
  def quantity_show_in_combobox
    max_quantity > 10 ? 10 : max_quantity
  end

  def check_duplicates
  	if TicketType.exists?(event: event, price: price)
  		errors.add(:base, "Cannot have duplicates")
  	end
  end

end
