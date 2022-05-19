# frozen_string_literal: true

module Task::Operation
  class Create < Trailblazer::Operation
    step Model(Task, :new)
    step Contract::Build(constant: Task::Contract::Create)
    step Policy::Guard(::Task::Policy::Guard.new)
    step Contract::Validate()
    step Contract::Persist()
    fail :status

    def status(ctx, **)
      ctx[:status] = ctx['result.policy.default'].failure? ? :not_found : :unprocessable_entity
    end
  end
end
