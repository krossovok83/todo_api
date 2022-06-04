# frozen_string_literal: true

module Task::Operation
  class Show < Trailblazer::Operation
    step Subprocess(::Task::Lib::Find)
    step Contract::Build(constant: Task::Contract::Create)
  end
end
