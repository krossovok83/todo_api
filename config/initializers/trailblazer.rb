# frozen_string_literal: true

require 'reform/form/active_model/validations'

Reform::Form.class_eval do
  include Reform::Form::ActiveModel::Validations
end
Rails.application.config.reform.validations = :active_model