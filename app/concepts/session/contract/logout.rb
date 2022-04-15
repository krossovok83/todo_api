# frozen_string_literal: true

require 'reform/form/validation/unique_validator'

module Session::Contract
  class Logout < Reform::Form
    property :token

    validates :token, presence: true
  end
end
