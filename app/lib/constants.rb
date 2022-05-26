# frozen_string_literal: true

class Constants
  TOKEN_LIFETIME = 24
  IMAGE_SIZE = 10 * 1024 * 1024
  IMAGE_TYPE = %w[jpg jpeg png].freeze
  COMMENT_LENGTH = 10..256
  PROJECT_LENGTH = 3..50
  TASK_LENGTH = 3..50
end
