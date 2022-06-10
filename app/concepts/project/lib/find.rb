# frozen_string_literal: true

module Project::Lib
  class Find < Trailblazer::Operation
    step :model!

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.projects.find_by(id: params[:id])
    end
  end
end
