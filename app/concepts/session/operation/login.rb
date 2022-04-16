# frozen_string_literal: true

module Session::Operation
  class Login < Trailblazer::Operation
    step Model(User, :find_by, :email)
    step :user_auth
    step :write_token

    def user_auth(ctx, **)
      ctx[:model].authenticate(ctx[:params][:password])
    end

    def write_token(ctx, **)
      ctx[:model].token = JsonWebToken.encode(user_id: ctx[:model].id)
      ctx[:time] = Time.now + 24.hours.to_i
      ctx[:model].save
    end
  end
end
