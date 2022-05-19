# frozen_string_literal: true

module Project::Policy
  class Guard
    def call(ctx, *_args)
      user = ctx[:current_user]
      params = ctx[:params]
      user.projects.where(id: params[:id]).present?
    end
  end
end
