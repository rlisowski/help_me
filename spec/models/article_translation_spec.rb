# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleTranslation, type: :model do
  it 'complains about unknown lang' do
    expect { ArticleTranslation.new(lang: :fr) }.to raise_exception(ArgumentError)
  end

  it 'validates quesiton and answer presence if lang is EN' do
    article_translation = ArticleTranslation.new(lang: :en)

    expect(article_translation).not_to be_valid
    expect(article_translation.errors[:question]).to be_present
    expect(article_translation.errors[:answer]).to be_present
  end

  it 'checks lang uniqueness in article scope' do
    article = Article.create!
    first_en_translation = ArticleTranslation.new(article: article, lang: :en, question: 'Why?', answer: 'For future.')
    second_en_translation = ArticleTranslation.new(article: article, lang: :en, question: 'Why?', answer: 'For fun.')

    expect(first_en_translation.save).to be true
    expect(second_en_translation.save).to be false
    expect(second_en_translation.errors[:lang]).to be_present
  end

  it 'allows to save all translations' do
    article = Article.create!
    en_translation = ArticleTranslation.new(article: article, lang: :en, question: 'Why?', answer: 'For future.')
    de_translation = ArticleTranslation.new(article: article, lang: :de, question: 'Warum?', answer: 'Für die Zukunft.')

    expect(en_translation.save).to be true
    expect(de_translation.save).to be true
  end

  it 'allows to save empty data for DE lang' do
    article_translation = ArticleTranslation.new(lang: :de, article: Article.new)

    expect(article_translation).to be_valid
  end

  it 'complains about missing part of the translation' do
    article_translation = ArticleTranslation.new(lang: :de, article: Article.new, question: 'Complain?')

    expect(article_translation).not_to be_valid
    expect(article_translation.errors[:answer]).to be_present
  end
end
