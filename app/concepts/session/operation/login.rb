# frozen_string_literal: true

module Session::Operation
  class Login < Trailblazer::Operation
    step Model(User, :find_by, :email)
    step :user_auth
    step :new_session

    def user_auth(_ctx, model:, params:, **)
      model.authenticate(params[:password])
    end

    def new_session(ctx, model:, **)
      user_payload = { user_id: model.id }
      session = JWTSessions::Session.new(refresh_by_access_allowed: true,
                                         payload: user_payload,
                                         refresh_payload: user_payload)
      ctx[:session] = session.login
    end
  end
end
