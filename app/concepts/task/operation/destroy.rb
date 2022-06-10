# frozen_string_literal: true

module Task::Operation
  class Destroy < Trailblazer::Operation
    step Subprocess(::Task::Lib::Find)
    step :delete

    def delete(_ctx, model:, **)
      model.destroy
    end
  end
end
