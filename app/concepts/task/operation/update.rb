# frozen_string_literal: true

module Task::Operation
  class Update < Trailblazer::Operation
    step Subprocess(::Task::Operation::Show)
    step Contract::Validate()
    step Contract::Persist()
    step :position_change
    fail :status

    def position_change(_ctx, model:, params:, **)
      model.move_higher if params[:position_up]
      model.move_lower if params[:position_down]
      true
    end

    def status(ctx, **)
      ctx[:status] = ctx[:model].nil? ? :not_found : :unprocessable_entity
    end
  end
end
