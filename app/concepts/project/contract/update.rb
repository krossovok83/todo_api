# frozen_string_literal: true

module Project::Contract
  class Update < Reform::Form
    feature Dry

    property :title

    validation do
      params do
        required(:title).filled(size?: Constants::PROJECT_LENGTH)
      end
    end
  end
end
