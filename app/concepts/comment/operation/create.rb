# frozen_string_literal: true

module Comment::Operation
  class Create < Trailblazer::Operation
    step Model(Comment, :new)
    step :image_attach
    step Contract::Build(constant: Comment::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()

    def image_attach(ctx, **)
      file = ctx[:params][:image]
      return true unless file

      ctx[:model].image = File.open(file, binmode: true)
    end
  end
end
