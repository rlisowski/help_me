# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Translator do
  let!(:article) { create(:article) }
  let!(:en_article) do
    create(:article_translation, lang: :en, article: article)
  end
  let!(:de_article) do
    create(:article_translation,
           lang: :de,
           article: article,
           question: 'Übersetzung in Bearbeitung',
           answer: 'Übersetzung in Bearbeitung')
  end

  it 'translates from EN to DE', :vcr do
    expect(de_article.question).to eq('Übersetzung in Bearbeitung')
    expect(de_article.answer).to eq('Übersetzung in Bearbeitung')

    described_class.new(article.id).call

    de_article.reload
    expect(de_article.question).to be_present
    expect(de_article.answer).to be_present
    expect(de_article.question).not_to eq('Übersetzung in Bearbeitung')
    expect(de_article.answer).not_to eq('Übersetzung in Bearbeitung')
  end
end
