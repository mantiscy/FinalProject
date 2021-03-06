class ProductsController < ApplicationController

  before_filter :authenticate_user!
  # GET /products
  # GET /products.json
  def index

    @products = current_user.products #.where('available = ?', 'y')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    3.times{ @product.images.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    2.times{ @product.images.build }
  end

  # POST /products
  # POST /products.json
  def create
    
    @product = Product.new(params[:product])
    @product.available = 'y'
    @products = current_user.products
    respond_to do |format|
      if @product.save
        current_user.products << @product
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render json: @products, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def available_product
    p = Product.find(params[:id])
    @product = Product.new
    @product.name = p.name
    @product.user = current_user
    @product.description = p.description
    @product.images = p.images
    @product.available = 'y'
    @product.save
    respond_to do |format|
      format.html { render :template => "products/show" }
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
