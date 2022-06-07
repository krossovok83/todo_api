# frozen_string_literal: true

module Comment::Operation
  class Create < Trailblazer::Operation
    step Rescue(ActiveRecord::RecordNotFound) { step :model! }
    step :image_attach
    step Contract::Build(constant: Comment::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    fail :status

    def model!(ctx, current_user:, params:, **)
      ctx[:model] = current_user.tasks.find(params[:task_id]).comments.new
    end

    def status(ctx, **)
      ctx[:status] = ctx[:model].nil? ? :not_found : :unprocessable_entity
    end

    def image_attach(_ctx, model:, params:, **)
      file = params[:image]
      return true unless file

      model.pictures.new(image: File.open(file, binmode: true))
    end
  end
end
