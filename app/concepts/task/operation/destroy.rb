# frozen_string_literal: true

module Task::Operation
  class Destroy < Trailblazer::Operation
    step Subprocess(::Task::Operation::Show)
    step :delete

    def delete(ctx, **)
      ctx[:model].destroy
    end
  end
end
