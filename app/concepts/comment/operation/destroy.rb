# frozen_string_literal: true

module Comment::Operation
  class Destroy < Trailblazer::Operation
    step :find_comment
    step :delete

    def find_comment(ctx, **)
      params = ctx[:params]
      user = ctx[:current_user]
      project = user.projects.find(params[:project_id])
      ctx[:model] = project.tasks.find(params[:task_id]).comments.find(params[:id])
    end

    def delete(ctx, **)
      ctx[:model].destroy
    end
  end
end
