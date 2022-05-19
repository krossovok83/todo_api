# frozen_string_literal: true

module Comment::Operation
  class Create < Trailblazer::Operation
    step Model(Comment, :new)
    step :image_attach
    step Contract::Build(constant: Comment::Contract::Create)
    step Policy::Guard(::Comment::Policy::Guard.new)
    step Contract::Validate()
    step Contract::Persist()
    fail :status

    def status(ctx, **)
      ctx[:status] = ctx['result.policy.default'].failure? ? :not_found : :unprocessable_entity
    end

    def image_attach(ctx, **)
      file = ctx[:params][:image]
      return true unless file

      ctx[:model].image = File.open(file, binmode: true)
    end
  end
end
