class OffersController < ApplicationController
  # GET /offers
  # GET /offers.json
  def index
    @offers = current_user.offers

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offers }
    end
  end

  def add_first_item
    @product = Product.find(params[:id]);
    @offer = Offer.new
    @offer.products << @product
    @offer.completed = 'n'
    @offer.initiated_by = current_user.id.to_s
    @offer.users << current_user
    @offer.users << @product.user
    @offer.save
    respond_to do |format|
      format.html { render :template => "offers/add" }
    end
  end

  def finalize_offer
    
    p_ids = params[:@offer][:product_ids]
    @offer = Offer.find(params[:id])
    @offer.products = []
    p_ids.each do |pid|
      @offer.products << Product.find(pid)
    end

    if @offer.users[0] == current_user
      @user2 = @offer.users[1]
    else
      @user2 = @offer.users[0]
    end

    @offer.initiated_by = current_user.id.to_s
    @offer.save
    UserMailer.offer_confirmation(current_user, @offer).deliver
    UserMailer.new_offer(@user2, @offer).deliver
    redirect_to offers_path
  end

  def add
    @offer = Offer.find(params[:id])
    @products = []
    @offer.products.each do |p|
      if p.user != current_user
        @products << p
      end
    end
  
  end

  def accept #Make the swap of the items
    @offer = Offer.find(params[:id])
    user1 = @offer.users[0]
    user2 = @offer.users[1]
    user1_products = []
    user2_products = []
    @offer.products.each do |p|
      if p.user == user1
        user1_products << p
        #user1.products.find(p.id).delete
      else
        user2_products << p
        #user2.products.find(p.id).delete
      end
    end
    user1_products.each do |p|
      p.user = user2
      p.save
      user2.products << p
    end
    user2_products.each do |p|
      p.user = user1
      p.save
      user1.products << p
    end
    user1.save
    user2.save
    @offer.completed = 'y'
    @offer.save
    UserMailer.offer_completed(user1, @offer).deliver
    UserMailer.offer_completed(user2, @offer).deliver
    redirect_to home_index_url
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(params[:offer])

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render json: @offer, status: :created, location: @offer }
      else
        format.html { render action: "new" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end
end
