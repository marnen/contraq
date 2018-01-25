Rails.application.configure do
  default_locale = config.i18n.default_locale
  config.i18n.available_locales = [default_locale, :en, :'en-US'].compact # see https://github.com/stympy/faker/issues/480 and https://github.com/stympy/faker/issues/266
end
