# frozen_string_literal: true

module Project::Operation
  class Update < Trailblazer::Operation
    step Subprocess(::Project::Operation::Show)
    step Contract::Validate()
    step Contract::Persist()
    fail :status

    def status(ctx, **)
      ctx[:status] = if ctx['result.model'].failure? || ctx['result.policy.default'].failure?
                       :not_found
                     else
                       :unprocessable_entity
                     end
    end
  end
end
