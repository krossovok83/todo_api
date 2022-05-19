# frozen_string_literal: true

module Session::Operation
  class Authorization < Trailblazer::Operation
    step :check_token
    fail :unauthorized
    step :decoded
    step :current_user

    def check_token(ctx, **)
      return false unless ctx[:token]

      @token = ctx[:token].split[1]
      @user = User.find_by(token: @token)
      @user.present?
    end

    def decoded(ctx, **)
      @decoded = JsonWebToken.decode(@token)
    rescue JWT::DecodeError => e
      ctx[:errors] = e
      false if e.present?
    end

    def current_user(ctx, **)
      ctx[:current_user] = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      ctx[:errors] = e
      false if e.present? || @user != ctx[:current_user]
    end

    def unauthorized(ctx, **)
      ctx[:errors] = Exceptions::NotAuthorized.new
    end
  end
end
