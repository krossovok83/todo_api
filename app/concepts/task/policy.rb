# frozen_string_literal: true

module Task::Policy
  class Guard
    def call(ctx, *_args)
      user = ctx[:current_user]
      params = ctx[:params]
      user.projects.where(id: params[:project_id]).present?
    end
  end
end
