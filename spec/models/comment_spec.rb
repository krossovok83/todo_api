# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  it { should belong_to(:task) }
end
