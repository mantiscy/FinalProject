class Image < ActiveRecord::Base
  belongs_to :product
  mount_uploader :product_image, ProductImageUploader
  # attr_accessible :title, :body
end
