class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.deletion_confirmation.subject
  #
  def deletion_confirmation(user)
  

    mail to: user.email, subject: "registration confirmation"
  end
end
