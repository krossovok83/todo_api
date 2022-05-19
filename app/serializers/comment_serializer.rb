# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :image
end
