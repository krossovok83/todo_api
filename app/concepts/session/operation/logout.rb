# frozen_string_literal: true

module Session::Operation
  class Logout < Trailblazer::Operation
    step :remove_token

    def remove_token(_ctx, params:, **)
      JWTSessions::Session.new.flush_by_token(params[:token])
    end
  end
end
