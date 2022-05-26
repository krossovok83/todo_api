# frozen_string_literal: true

module Task::Contract
  class Create < Reform::Form
    property :title
    property :project_id
    property :deadline
    property :position
    property :completed

    validates :title, presence: true, length: { in: Constants::TASK_LENGTH }
  end
end
