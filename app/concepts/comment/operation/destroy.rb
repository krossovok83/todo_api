# frozen_string_literal: true

module Comment::Operation
  class Destroy < Trailblazer::Operation
    step Model(Comment, :find_by)
    step Policy::Guard(::Comment::Policy::Guard.new)
    step :delete

    def delete(ctx, **)
      ctx[:model].destroy
    end
  end
end
