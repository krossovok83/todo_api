# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :token
  attribute :exp do |object|
    Time.at(JsonWebToken.decode(object.token)[:exp]).strftime('%m-%d-%Y %H:%M')
  end
end
