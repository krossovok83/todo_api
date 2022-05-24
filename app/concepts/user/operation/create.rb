# frozen_string_literal: true

module User::Operation
  class Create < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    step Subprocess(::Session::Operation::Login)
  end
end
