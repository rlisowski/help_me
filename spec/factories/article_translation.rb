# frozen_string_literal: true

FactoryBot.define do
  factory :article_translation do
    article
    lang { :en }
    question { Faker::Lorem.sentence }
    answer { Faker::Lorem.sentence }
  end
end
