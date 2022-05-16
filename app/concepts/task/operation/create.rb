# frozen_string_literal: true

module Task::Operation
  class Create < Trailblazer::Operation
    step Model(Task, :new)
    step Contract::Build(constant: Task::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end
end
