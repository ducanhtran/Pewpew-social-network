module UsersHelper
  def gravatar_for user, opts = {size: Settings.avatar.size_default, class: "gravatar"}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{opts[:size]}"
    image_tag gravatar_url, alt: user.name, class: "#{opts[:class]}"
  end
end
