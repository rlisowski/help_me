# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'creates EN translation' do
    article = Article.new(article_translations_attributes: [{ lang: :en, question: 'Eh?', answer: 'Dunno.' }])

    expect(article.save).to be true
    en = article.article_translations.find_by(lang: :en)
    expect(en.question).to eq 'Eh?'
    expect(en.answer).to eq 'Dunno.'
  end

  it 'complains about missing part of the translation' do
    translations = [
      { lang: :en, question: 'Why?', answer: '' },
      { lang: :de, question: '', answer: 'Mhh.' }
    ]
    article = Article.new(article_translations_attributes: translations)

    expect(article.save).to be false
    expect(article.errors['article_translations[0].answer']).to be_present
    expect(article.errors['article_translations[1].question']).to be_present
  end
end
