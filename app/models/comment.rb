# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :task
  include ImageUploader::Attachment(:image)
end
