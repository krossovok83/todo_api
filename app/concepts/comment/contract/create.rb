# frozen_string_literal: true

module Comment::Contract
  class Create < Reform::Form
    property :task_id
    property :body
    property :image_data

    validates :body, length: { in: Constants::COMMENT_LENGTH }, allow_blank: true
  end
end
