class ForgotPasswordMailer < ApplicationMailer
  default :from => 'test@onebatonapp.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_forgot_password_email(user, url)
    @user = user
    @url = url
    mail( :to => @user.email,
    :subject => 'Forgot Password' )
  end
end
