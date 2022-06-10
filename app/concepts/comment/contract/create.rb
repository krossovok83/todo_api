# frozen_string_literal: true

module Comment::Contract
  class Create < Reform::Form
    feature Dry

    property :task_id
    property :body
    property :image, from: :pictures, virtual: true

    validation do
      params do
        optional(:body).maybe(size?: Constants::COMMENT_LENGTH)
        required(:task_id).filled
        optional(:pictures)
      end

      rule(:pictures) do
        if value
          key.failure('not format') unless value.content_type.in?(Constants::IMAGE_TYPE)
          key.failure('not size') if value.tempfile.size > Constants::IMAGE_SIZE
        end
      end
    end
  end
end
