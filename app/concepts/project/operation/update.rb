# frozen_string_literal: true

module Project::Operation
  class Update < Trailblazer::Operation
    step Subprocess(::Project::Lib::Find)
    step Contract::Build(constant: Project::Contract::Update)
    step Contract::Validate()
    step Contract::Persist()
    step :status_ok
    fail :status

    def status(ctx, **)
      ctx[:status] = ctx[:model].nil? ? :not_found : :unprocessable_entity
    end

    def status_ok(ctx, **)
      ctx[:status] = :ok
    end
  end
end
