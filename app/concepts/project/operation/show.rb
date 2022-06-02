# frozen_string_literal: true

module Project::Operation
  class Show < Trailblazer::Operation
    class FindModel < Trailblazer::Operation
      step Rescue(ActiveRecord::RecordNotFound) { step :model! }

      def model!(ctx, current_user:, params:, **)
        ctx[:model] = current_user.projects.find(params[:id])
      end
    end

    step Subprocess(FindModel)
    step Contract::Build(constant: Project::Contract::Create)
  end
end
