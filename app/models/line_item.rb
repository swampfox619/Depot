class LineItem < ActiveRecord::Base
  belongs_to :order, required: false
  belongs_to :product, required: false
  belongs_to :cart
  
  def total_price
    product.price * quantity
  end
  
end
