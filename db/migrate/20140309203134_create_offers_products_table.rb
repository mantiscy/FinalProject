class CreateOffersProductsTable < ActiveRecord::Migration
  def change
    create_table :offers_products do |t|

      t.references :offer, :null => false
      t.references :product, :null => false

    end
  end
end
