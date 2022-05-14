# frozen_string_literal: true

module Project::Operation
  class Update < Trailblazer::Operation
    step Subprocess(::Project::Operation::Show)
    step Contract::Validate()
    step Contract::Persist()
  end
end
