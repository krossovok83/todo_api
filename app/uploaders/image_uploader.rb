# frozen_string_literal: true

class ImageUploader < Shrine
  Attacher.validate do
    validate_extension Constants::IMAGE_TYPE
    validate_max_size Constants::IMAGE_SIZE
  end
end
