class Offer < ActiveRecord::Base
  # attr_accessible :title, :body

  has_and_belongs_to_many :products
  has_and_belongs_to_many :users

  def make_swap
    user1 = self.users[0]
    user2 = self.users[1]
    user1_products = []
    user2_products = []
    self.products.each do |p|
      p.offers.each do |o|
        if o != self && o.completed == 'n'
          #UserMailer.offer_cancelled(@user2, self).deliver
          o.destroy
        end
      end
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
      p.available = 'n'
      p.save
      user2.products << p
    end
    user2_products.each do |p|
      p.user = user1
      p.available = 'n'
      p.save
      user1.products << p
    end
    user1.save
    user2.save
    self.completed = 'y'
    self.save
  end

end
