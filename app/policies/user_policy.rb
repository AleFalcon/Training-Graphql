class UserPolicy < ApplicationPolicy
  def create?
    unless validation_wolox_domain(record[:email])
      return { result: false,
        message: I18n.t('pundit.error.creation.user.wolox_domain'),
        reason: I18n.t('field.email', reason: record[:email]) }
    end
    unless validation_email_unique(record[:email])
      return { result: false,
        message: I18n.t('pundit.error.creation.user.email_unique'),
        reason: I18n.t('field.email', reason: record[:email]) }
    end
    unless validation_long_password(record[:password])
      return { result: false,
        message: I18n.t('pundit.error.creation.user.long_password'),
        reason: I18n.t('field.password', reason: record[:password]) }
    end

    { result: true, message: nil, reason: nil }
  end

  def validation_wolox_domain(email)
    domain = '@wolox.com.ar'
    position = email =~ /#{domain}/
    return false if position.nil?

    email[position..(email.length)] == domain
  end

  def validation_email_unique(email)
    (User.find_by email: email).nil?
  end

  def validation_long_password(password)
    password.length >= 8
  end
end
