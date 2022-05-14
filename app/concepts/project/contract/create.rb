# frozen_string_literal: true

module Project::Contract
  class Create < Reform::Form
    property :title
    property :user_id

    validates :title, presence: true, length: { in: 3..50 }, unique: true
  end
end
