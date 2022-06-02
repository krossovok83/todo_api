# frozen_string_literal: true

module Task::Operation
  class Show < Trailblazer::Operation
    class FindModel < Trailblazer::Operation
      step Rescue(ActiveRecord::RecordNotFound) { step :model! }

      def model!(ctx, current_user:, params:, **)
        ctx[:model] = current_user.tasks.find(params[:id])
      end
    end

    step Subprocess(FindModel)
    step Contract::Build(constant: Task::Contract::Create)
  end
end
