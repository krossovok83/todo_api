# frozen_string_literal: true

module User::Contract
  class Create < Reform::Form
    feature Dry

    property :email
    property :password
    property :password_confirmation, virtual: true

    validation do
      params do
        required(:email).filled(size?: Constants::EMAIL_LENGTH)
        required(:password).filled(size?: Constants::PASSWORD_LENGTH, format?: /^[a-zA-Z0-9]*$/)
        required(:password_confirmation).filled
      end

      rule(:password_confirmation, :password) do
        key.failure(I18n.t('.password_mismatch')) if values[:password_confirmation] != values[:password]
      end

      rule(:email) do
        key.failure(I18n.t('.non_uniq_email')) if User.where(email: value).present?
      end
    end
  end
end
