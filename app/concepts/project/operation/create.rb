# frozen_string_literal: true

module Project::Operation
  class Create < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Project::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()

    def model!(ctx, current_user:, **)
      ctx[:model] = current_user.projects.new
    end
  end
end
