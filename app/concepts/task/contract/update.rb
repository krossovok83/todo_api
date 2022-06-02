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
        optional(:deadline).maybe(:date_time?)
        optional(:completed).maybe(:bool?)
      end
    end
  end
end
