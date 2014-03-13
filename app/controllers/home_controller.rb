class HomeController < ApplicationController
  def index
    @q = Product.search(params[:q])
    @products = @q.result(distinct: true)
  end

  def search
    
  end
end
