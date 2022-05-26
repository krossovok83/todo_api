# frozen_string_literal: true

module Project::Contract
  class Create < Reform::Form
    property :title
    property :user_id

    validates :title, presence: true, length: { in: Constants::PROJECT_LENGTH }, unique: true
  end
end
