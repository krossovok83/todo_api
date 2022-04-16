# frozen_string_literal: true

module Session::Operation
  class Logout < Trailblazer::Operation
    step Model(User, :find_by)
    step :remove_token

    def remove_token(ctx, **)
      ctx[:model].update(token: nil)
    end
  end
end
