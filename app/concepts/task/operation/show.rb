# frozen_string_literal: true

module Task::Operation
  class Show < Trailblazer::Operation
    step Rescue(ActiveRecord::RecordNotFound) { step :model! }
    step Contract::Build(constant: Task::Contract::Create)

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.tasks.find(params[:id])
    end
  end
end
