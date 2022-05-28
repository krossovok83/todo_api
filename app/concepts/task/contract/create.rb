# frozen_string_literal: true

module Task::Contract
  class Create < Reform::Form
    feature Dry

    property :title
    property :project_id
    property :deadline
    property :completed

    validation do
      params do
        required(:title).filled(size?: Constants::TASK_LENGTH)
        required(:project_id).filled
        optional(:deadline).maybe(:date_time?)
        optional(:completed).maybe(:bool?)
      end
    end
  end
end
