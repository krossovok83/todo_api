# frozen_string_literal: true

RSpec.describe Task, type: :model do
  it { should belong_to(:project) }
  it { should have_many(:comments) }
end
