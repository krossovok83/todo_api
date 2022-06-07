# frozen_string_literal: true

RSpec.describe Picture, type: :model do
  it { should belong_to(:comment) }
end
