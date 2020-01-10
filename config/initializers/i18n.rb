Rails.application.configure do
  # The default locale loading mechanism in Rails does not load locale files in
  # nested dictionaries, like we have here. So, for this to work, we must
  # explicitly tell Rails to look further.
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

  # Restrict which locales should be loaded by rails-i18n. By default loads all locales.
  # config.i18n.available_locales = :en
end
