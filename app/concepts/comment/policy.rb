# frozen_string_literal: true

module Comment::Policy
  class Guard
    def call(ctx, *_args)
      user = ctx[:current_user]
      params = ctx[:params]
      user.projects.where(id: params[:project_id]).present? &&
        Project.find(params[:project_id]).tasks.where(id: params[:task_id]).present?
    end
  end
end
