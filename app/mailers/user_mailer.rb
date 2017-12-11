class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, object: t("user_mailer.activation_object")
  end

  def password_reset
  end
end
