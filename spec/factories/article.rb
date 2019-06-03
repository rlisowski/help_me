# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    trait :with_translations do
      after(:create) do |article, _evaluator|
        create :article_translation, article: article
      end
    end
  end
end
