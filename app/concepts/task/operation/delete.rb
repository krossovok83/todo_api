# frozen_string_literal: true

module Task::Operation
  class Delete < Trailblazer::Operation
    step Subprocess(::Task::Operation::Update::FindTask)
    step :delete

    def delete(ctx, **)
      ctx[:model].destroy
    end
  end
end
