class RemoveImageFromProductsTable < ActiveRecord::Migration
  def up
    remove_column :products, :product_image
  end

  def down
    add_column :products, :product_image, :string
  end
end
