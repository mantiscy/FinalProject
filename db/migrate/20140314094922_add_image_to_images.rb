class AddImageToImages < ActiveRecord::Migration
  def change
    add_column :images, :product_image, :string
  end
end
