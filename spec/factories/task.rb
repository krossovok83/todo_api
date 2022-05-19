# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { ::FFaker::Company.catch_phrase }
  end
end
