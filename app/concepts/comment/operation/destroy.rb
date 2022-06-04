# frozen_string_literal: true

module Comment::Operation
  class Destroy < Trailblazer::Operation
    step :model!
    step :delete

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.comments.find_by(id: params[:id])
    end

    def delete(_ctx, model:, **)
      model.destroy
    end
  end
end
