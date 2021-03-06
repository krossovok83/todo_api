# frozen_string_literal: true

class Constants
  IMAGE_SIZE = 10 * 1024 * 1024
  IMAGE_TYPE = %w[image/jpeg image/jpg image/png].freeze
  COMMENT_LENGTH = 10..256
  PROJECT_LENGTH = 3..50
  TASK_LENGTH = 3..50
  EMAIL_LENGTH = 3..50
  PASSWORD_LENGTH = 8
end
