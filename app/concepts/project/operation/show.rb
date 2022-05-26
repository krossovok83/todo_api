# frozen_string_literal: true

module Project::Operation
  class Show < Trailblazer::Operation
    step Model(Project, :find_by)
    step Contract::Build(constant: Project::Contract::Create)
    step Policy::Pundit(Project::Policy, :show?)
  end
end
