class BilldeskMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.billdesk_mailer.regular.subject
  #
  def regular(cart)
    # @greeting = "Hi"
    @c = cart
    if @c.is_regular?
      mail to: cart.user.email, subject: "Your Bill for order at "+cart.restaurant.name
    else
      mail to: cart.user.email, subject: "Time for yay! Someone just completed your remaining foodlane bill" 
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.billdesk_mailer.club.subject
  #
  def club(cb)
    mail to: "to@example.org"
  end
end
