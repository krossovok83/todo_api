# frozen_string_literal: true

class Project::Policy
  def initialize(user, model)
    @user = user
    @model = model
  end

  def show?
    @model.user == @user
  end
end
