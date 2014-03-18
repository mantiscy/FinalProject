class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered")
  end

  def new_offer(user, offer)
    mail(:to => user.email, :subject => "You have received a new offer!")
  end
end
