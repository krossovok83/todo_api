# frozen_string_literal: true

module Task::Operation
  class Create < Trailblazer::Operation
    step Rescue(ActiveRecord::RecordNotFound) { step :model! }
    step Contract::Build(constant: Task::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    fail :status

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.projects.find(params[:project_id]).tasks.new
    end

    def status(ctx, **)
      ctx[:status] = ctx[:model].nil? ? :not_found : :unprocessable_entity
    end
  end
end
