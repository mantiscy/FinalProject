class OffersController < ApplicationController
  # GET /offers
  # GET /offers.json
  def index
    #@offers = current_user.offers
    @offers = Offer.where("completed = ?", 'n').page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offers }
    end
  end

  def completed_offers
    @offers = Offer.where("completed = ?", 'y').page(params[:page])
    respond_to do |format|
      format.html 
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
    # @offer.save
    respond_to do |format|
      format.html { render :template => "offers/add" }
    end
  end

  def finalize_offer
    
    @offer = Offer.new
    @offer.completed = 'n'
    @offer.initiated_by = current_user.id.to_s
    @offer.users << current_user

    p_ids = params[:@offer][:product_ids]
    # @offer = Offer.find(params[:id])
    @offer.products = []
    p_ids.each do |pid|
      prod = Product.find(pid)

      @offer.products << prod
      if prod.user != current_user
        @offer.users << prod.user
      end
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

  def amend
    @offer = Offer.find(params[:id])  
  end

  def update

    @offer = Offer.find(params[:id])
    p_ids = params[:@offer][:product_ids]
    # @offer = Offer.find(params[:id])
    @offer.products = []
    p_ids.each do |pid|
      prod = Product.find(pid)
      @offer.products << prod
    end

    @offer.initiated_by = current_user.id.to_s
    @offer.save
    # raise
    # UserMailer.amend_confirmation(current_user, @offer).deliver
    # UserMailer.amend_offer(@user2, @offer).deliver
    redirect_to offers_path
  end

  def accept #Make the swap of the items
    @offer = Offer.find(params[:id])
    user1 = @offer.users[0]
    user2 = @offer.users[1]
    @offer.make_swap
    @offer.save
    UserMailer.offer_completed(user1, @offer).deliver
    UserMailer.offer_completed(user2, @offer).deliver
    redirect_to home_index_url
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
