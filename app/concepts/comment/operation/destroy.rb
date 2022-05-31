# frozen_string_literal: true

module Comment::Operation
  class Destroy < Trailblazer::Operation
    step Rescue(ActiveRecord::RecordNotFound) { step :model! }
    step :delete

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.comments.find(params[:id])
    end

    def delete(_ctx, model:, **)
      model.destroy
    end
  end
end
