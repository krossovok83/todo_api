# frozen_string_literal: true

module Project::Contract
  class Create < Reform::Form
    feature Dry

    property :title
    property :user_id

    validation do
      params do
        required(:title).filled(size?: Constants::PROJECT_LENGTH)
        required(:user_id).filled
      end

      rule(:title, :user_id) do
        if User.find(values[:user_id]).projects.where(title: values[:title]).present?
          key.failure(I18n.t('.non_uniq_project'))
        end
      end
    end
  end
end
