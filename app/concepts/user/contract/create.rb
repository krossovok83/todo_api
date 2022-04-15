# frozen_string_literal: true

require 'reform/form/validation/unique_validator'

module User::Contract
  class Create < Reform::Form
    property :email
    property :password
    property :password_confirmation, virtual: true

    validates :email, presence: true, length: { in: 3..50 }, unique: true
    validates :password, length: { is: 8 }, format: { with: /\w/ }
    validate :password_confirm?

    def password_confirm?
      errors.add(:password, 'Password mismatch') if password != password_confirmation
    end
  end
end
