# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { should have_many(:projects) }
end
