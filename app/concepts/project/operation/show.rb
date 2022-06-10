# frozen_string_literal: true

module Project::Operation
  class Show < Trailblazer::Operation
    step Subprocess(::Project::Lib::Find)
    step Contract::Build(constant: Project::Contract::Create)
  end
end
