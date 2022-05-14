# frozen_string_literal: true

module Project::Operation
  class Create < Trailblazer::Operation
    step Model(Project, :new)
    step :user_define
    step Contract::Build(constant: Project::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()

    def user_define(ctx, **)
      ctx[:model].user = ctx[:user]
    end
  end
end
