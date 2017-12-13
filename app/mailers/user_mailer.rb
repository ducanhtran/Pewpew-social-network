class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, object: t("user_mailer.activation_object")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("user_mailer.reset_object")
  end
end
