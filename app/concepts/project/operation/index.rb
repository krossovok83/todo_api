# frozen_string_literal: true

module Project::Operation
  class Index < Trailblazer::Operation
    step :model

    def model(ctx, current_user:, **)
      ctx[:model] = current_user.projects
    end
  end
end
