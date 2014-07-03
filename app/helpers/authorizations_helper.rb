# encoding: UTF-8
module AuthorizationsHelper

  def button(url,text)
    html = "#{link_to text, url}" if current_user.authorized?(url)
    html
  end

end