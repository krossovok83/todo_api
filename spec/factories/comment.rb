# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { ::FFaker::Lorem.phrase }
  end
end
