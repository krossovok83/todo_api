# frozen_string_literal: true

module Task::Operation
  class Show < Trailblazer::Operation
    step Model(Task, :find_by)
    step Contract::Build(constant: Task::Contract::Create)
    step Policy::Guard(::Task::Policy::Guard.new)
  end
end
