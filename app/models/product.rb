class Product < ActiveRecord::Base

  belongs_to :user
  attr_accessible :description, :name, :product_image, :category_ids, :images_attributes
  has_and_belongs_to_many :offers
  has_and_belongs_to_many :categories
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  #mount_uploader :product_image, ProductImageUploader

end
