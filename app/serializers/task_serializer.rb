# frozen_string_literal: true

class TaskSerializer
  include JSONAPI::Serializer
  attributes :title, :deadline, :position, :completed

  belongs_to :project
  has_many :comments
end
