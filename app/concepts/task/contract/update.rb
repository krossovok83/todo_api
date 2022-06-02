# frozen_string_literal: true

module Task::Contract
  class Update < Reform::Form
    feature Dry

    property :title
    property :deadline
    property :completed

    validation do
      params do
        required(:title).filled(size?: Constants::TASK_LENGTH)
      end
    end
  end
end
