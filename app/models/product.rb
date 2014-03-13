class Product < ActiveRecord::Base

  belongs_to :user
  attr_accessible :description, :name, :product_image, :category_ids
  has_and_belongs_to_many :offers
  has_and_belongs_to_many :categories

  mount_uploader :product_image, ProductImageUploader

end
