# frozen_string_literal: true

RSpec.describe Project, type: :model do
  it { should belong_to(:user) }
end
