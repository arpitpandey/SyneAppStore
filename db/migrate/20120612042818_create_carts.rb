class CreateCarts < ActiveRecord::Migration
   def self.up
    create_table :carts do |t|
      t.string :sessionId
      t.integer :productId
      t.decimal :productPrice
      t.string :productName
      t.integer :quantity

      t.timestamps
    end
  end
  def self.down
	drop_table :carts
  end
end
