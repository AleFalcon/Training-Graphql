class UserPolicy < ApplicationPolicy
  def create?
    unless validation_wolox_domain(record[:email])
      return { result: false, message: 'email does not belong to wolox.com.ar' }
    end
    unless validation_email_unique(record[:email])
      return { result: false, message: 'email does not unique' }
    end
    unless validation_long_password(record[:password])
      return { result: false, message: 'password very short' }
    end

    { result: true, message: nil }
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