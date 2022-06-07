# frozen_string_literal: true

module Comment::Contract
  class Create < Reform::Form
    feature Dry

    property :task_id
    property :body

    validation do
      params do
        optional(:body).maybe(size?: Constants::COMMENT_LENGTH)
        required(:task_id).filled
        optional(:image_data).maybe(:str?)
      end
    end
  end
end
