class HomeController < ApplicationController
  def index
    prods = Product.where('available = ?', 'y')
    @products = []
    prods.each do |p|
      if p.user != current_user
        @products << p
      end
    end
  end

  def search
    
  end

  def cat_show
    @products = Category.find(params[:id]).products
    render :template => "home/index"
  end
end
