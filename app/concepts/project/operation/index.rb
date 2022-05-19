# frozen_string_literal: true

module Project::Operation
  class Index < Trailblazer::Operation
    step :find_all

    def find_all(ctx, **)
      ctx[:model] = ctx[:current_user].projects
    end
  end
end