class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.float :bedrooms
      t.integer :minutes
      t.integer :price

      t.timestamps
    end
  end
end
