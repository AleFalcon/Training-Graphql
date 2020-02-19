# frozen_string_literal: true
include ActionController::Helpers
include ActionController::Cookies

class ApplicationController < ActionController::API
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
