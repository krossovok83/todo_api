# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :comment
  include ImageUploader::Attachment(:image)
end
