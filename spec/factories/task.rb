# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { ::FFaker::AnimalUS.common_name }
  end
end
