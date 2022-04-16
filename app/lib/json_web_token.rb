# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.credentials.jwt[:secret].to_s

  def self.encode(payload, exp = Constants::TOKEN_LIFETIME.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
