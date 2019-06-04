# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesQuery do
  let!(:en_article) do
    create(:article_translation, lang: :en).article
  end
  let!(:de_article) do
    create(:article_translation, lang: :de).article
  end

  it 'fetches translations' do
    articles = ArticlesQuery.new.call
    expect(articles.first).to eq(en_article)
    expect(articles.last).to eq(de_article)
  end
end
