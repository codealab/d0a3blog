module ApplicationHelper

  def full_title(page_title)
    title = 'Demo App'
    if Panel.first
      title = Panel.first.name if !Panel.first.name.blank?
    end
    base_title = title
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def logo_app
    image = '/assets/D0A3-logo.png'
    if Panel.first
      image = Panel.first.logo.url(:thumb) if !Panel.first.logo.blank?
    end
    image
  end

end