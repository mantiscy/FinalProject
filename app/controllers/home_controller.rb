class HomeController < ApplicationController
  def index
    @products = Product.where('available = ?', 'y')
  end

  def search
    
  end

  def cat_show
    @products = Category.find(params[:id]).products
    render :template => "home/index"
  end
end
