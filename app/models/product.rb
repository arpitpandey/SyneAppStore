class Product < ActiveRecord::Base
  attr_accessible :description, :isactive, :name, :price, :ptype, :image
  has_attached_file :image
end
