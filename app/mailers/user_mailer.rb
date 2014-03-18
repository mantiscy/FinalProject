class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered")
  end

  def new_offer(user, offer)
    mail(:to => user.email, :subject => "You have received a new offer!")
  end

  def offer_confirmation(user, offer)
    mail(:to => user.email, :subject => "Offer successfully placed!")
  end

  def offer_completed(user, offer)
    mail(:to => user.email, :subject => "Congrats! Swap completed!")
  end
end
