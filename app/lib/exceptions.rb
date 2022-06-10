# frozen_string_literal: true

module Exceptions
  class NotAuthorized < StandardError
    def initialize(msg = nil)
      msg = 'Not authorized'
      super
    end
  end
end
