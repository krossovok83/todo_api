# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :email
  attribute :access_token do |_object, params|
    params[:access]
  end

  attribute :access_expires do |_object, params|
    params[:access_expires_at]
  end

  attribute :refresh_token do |_object, params|
    params[:refresh]
  end

  attribute :refresh_expires do |_object, params|
    params[:refresh_expires_at]
  end
end
