# frozen_string_literal: true

module Project::Operation
  class Update < Trailblazer::Operation
    step Subprocess(::Project::Operation::Show::FindModel)
    step Contract::Build(constant: Project::Contract::Update)
    step Contract::Validate()
    step Contract::Persist()
    fail :status

    def status(ctx, **)
      ctx[:status] = ctx[:model].nil? ? :not_found : :unprocessable_entity
    end
  end
end
