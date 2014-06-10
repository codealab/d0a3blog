I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}').to_s]
I18n.default_locale = :en