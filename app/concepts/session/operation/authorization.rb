# frozen_string_literal: true

module Session::Operation
  class Authorization < Trailblazer::Operation
    step :check_blacklist
    fail :unauthorized
    step :decoded
    step :current_user

    def check_blacklist(ctx, **)
      @token = ctx[:token]
      !BlackList.find_by(token: @token).present?
    end

    def decoded(*_args)
      @decoded = JsonWebToken.decode(@token)
    rescue JWT::DecodeError => e
      ctx[:errors] = e
      false if e.present?
    end

    def current_user(ctx, **)
      ctx[:user] = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      ctx[:errors] = e
      false if e.present?
    end

    def unauthorized(ctx, **)
      raise Exceptions::NotAuthorized, 'Not Authorized'
    rescue Exceptions::NotAuthorized => e
      ctx[:errors] = e
    end
  end
end
