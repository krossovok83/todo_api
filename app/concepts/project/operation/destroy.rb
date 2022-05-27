# frozen_string_literal: true

module Project::Operation
  class Destroy < Trailblazer::Operation
    step Subprocess(::Project::Operation::Show)
    step :delete

    def delete(_ctx, model:, **)
      model.destroy
    end
  end
end
