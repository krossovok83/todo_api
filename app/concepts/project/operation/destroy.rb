# frozen_string_literal: true

module Project::Operation
  class Destroy < Trailblazer::Operation
    step Subprocess(::Project::Operation::Show)
    step :delete

    def delete(ctx, **)
      ctx[:model].destroy
    end
  end
end
