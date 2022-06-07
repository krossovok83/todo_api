# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :pictures

  belongs_to :task
end
