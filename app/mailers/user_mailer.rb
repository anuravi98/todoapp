class UserMailer < ApplicationMailer
    default from: 'notifications@todoapp.com'

    CONTACT_EMAIL = "contact@todoapp.com"
    def send_email(email)
        @email = email
        @message= "U deleted a bunch of your todos"
        sleep 5 # this is for demonstration purposes of feeling the pain of a long page load.
        mail( :to => @email,
        :subject => 'Todo deleted.' )
      end
end
