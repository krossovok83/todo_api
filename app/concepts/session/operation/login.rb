# frozen_string_literal: true

module Session::Operation
  class Login < Trailblazer::Operation
    step Model(User, :find_by, :email)
    step :user_auth
    step :write_token

    def user_auth(_ctx, model:, params:, **)
      model.authenticate(params[:password])
    end

    def write_token(ctx, model:, **)
      model.token = JsonWebToken.encode(user_id: model.id)
      ctx[:time] = Time.now + 24.hours.to_i
      model.save
    end
  end
end
