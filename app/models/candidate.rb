class Candidate < ApplicationRecord
  with_options({ on: :register }) do |register|
    register.has_secure_password

    register.validates :username,
      presence: true,
      uniqueness: true,
      length: { within: 3..25 },
      format: {
        with: /\A[a-zA-Z0-9]+\z/,
        message: 'only alphanumerics',
      }

    register.validates :fullname,
      presence: true,
      length: { minimum: 1 },
      format: {
        with: /\A[a-zA-Z ]+\z/,
        message: 'only letters and space',
      }

    register.validates :password,
      presence: true,
      length: { minimum: 8 }
  end

  with_options({ on: :login }) do |login|
    login.has_secure_password

    login.validates :username,
      presence: true,
      length: { within: 3..25 },
      format: {
        with: /\A[a-zA-Z0-9]+\z/,
        message: 'only alphanumerics',
      }

    login.validates :password,
      presence: true,
      length: { minimum: 8 }
  end

  with_options({ on: :change_password }) do |change_password|
    change_password.validates :password,
      presence: true,
      length: { minimum: 8 }
  end
end
