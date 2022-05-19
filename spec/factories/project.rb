# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { ::FFaker::Color.name }
  end
end
