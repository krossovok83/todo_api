# frozen_string_literal: true

RSpec.describe Task, type: :model do
  it { should belong_to(:project) }
end
