# frozen_string_literal: true

module Task::Contract
  class Create < Reform::Form
    feature Dry

    property :title
    property :project_id

    validation do
      params do
        required(:title).filled(size?: Constants::TASK_LENGTH)
        required(:project_id).filled
      end
    end
  end
end
