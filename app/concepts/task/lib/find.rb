# frozen_string_literal: true

module Task::Lib
  class Find < Trailblazer::Operation
    step :model!

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.tasks.find_by(id: params[:id])
    end
  end
end
