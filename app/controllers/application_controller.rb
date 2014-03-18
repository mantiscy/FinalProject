class ApplicationController < ActionController::Base
  protect_from_forgery

  def search
    @product_results = []
    @product_results = Product.where("name like ?", "%#{params[:search]}%")
    @product_desc_results = Product.where("description like ?", "%#{params[:search]}%")
    # raise
  end
end
