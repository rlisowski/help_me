# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesQuery do
  let!(:article) { create(:article) }
  let!(:en_article) do
    create(:article_translation, lang: :en, article: article)
  end
  let!(:de_article) do
    create(:article_translation, lang: :de, article: article)
  end

  it 'fetches translations' do
    translations = ArticlesQuery.new.call.first.article_translations
    expect(translations.first).to eq(en_article)
    expect(translations.last).to eq(de_article)
  end
end
