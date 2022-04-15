# frozen_string_literal: true

module Session::Operation
  class Logout < Trailblazer::Operation
    step Model(BlackList, :new)
    step :assign_token
    step Contract::Build(constant: Session::Contract::Logout)
    step Contract::Validate()
    step Contract::Persist()

    def assign_token(ctx, **)
      ctx[:model].token = ctx[:token]
    end
  end
end
