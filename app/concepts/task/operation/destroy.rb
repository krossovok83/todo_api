# frozen_string_literal: true

module Task::Operation
  class Destroy < Trailblazer::Operation
    step Subprocess(::Task::Operation::Show)
    step :delete

    def delete(_ctx, model:, **)
      model.destroy
    end
  end
end
