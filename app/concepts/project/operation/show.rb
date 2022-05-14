# frozen_string_literal: true

module Project::Operation
  class Show < Trailblazer::Operation
    step :find_project
    step Contract::Build(constant: Project::Contract::Create)

    def find_project(ctx, **)
      ctx[:model] = ctx[:current_user].projects.find(ctx[:params][:id])
    end
  end
end
