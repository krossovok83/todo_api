# frozen_string_literal: true

module Task::Operation
  class Update < Trailblazer::Operation
    class FindTask < Trailblazer::Operation
      step :find_task
      step Contract::Build(constant: Task::Contract::Create)

      def find_task(ctx, **)
        params = ctx[:params]
        ctx[:model] = ctx[:current_user].projects.find(params[:project_id]).tasks.find(params[:id])
      end
    end

    step Subprocess(FindTask)
    step Contract::Validate()
    step Contract::Persist()
    step :position_change

    def position_change(ctx, **)
      model = ctx[:model]
      params = ctx[:params]
      model.move_higher if params[:position_up]
      model.move_lower if params[:position_down]
      true
    end
  end
end
