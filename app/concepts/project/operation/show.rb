# frozen_string_literal: true

module Project::Operation
  class Show < Trailblazer::Operation
    step Rescue(ActiveRecord::RecordNotFound) { step :model! }
    step Contract::Build(constant: Project::Contract::Create)

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.projects.find(params[:id])
    end
  end
end
