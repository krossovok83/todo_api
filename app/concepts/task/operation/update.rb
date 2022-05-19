# frozen_string_literal: true

module Task::Operation
  class Update < Trailblazer::Operation
    step Subprocess(::Task::Operation::Show)
    step Contract::Validate()
    step Contract::Persist()
    step :position_change
    fail :status

    def position_change(ctx, **)
      model = ctx[:model]
      params = ctx[:params]
      model.move_higher if params[:position_up]
      model.move_lower if params[:position_down]
      true
    end

    def status(ctx, **)
      ctx[:status] = if ctx['result.model'].failure? || ctx['result.policy.default'].failure?
                       :not_found
                     else
                       :unprocessable_entity
                     end
    end
  end
end
