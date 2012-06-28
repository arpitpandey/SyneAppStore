class Cart < ActiveRecord::Base
  attr_accessible :productId, :productName, :productPrice, :quantity, :sessionId
end
