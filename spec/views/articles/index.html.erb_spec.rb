# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'articles/index.html.erb', type: :view do
  it 'displays articles' do
    articles = [
      create(:article, :with_translations),
      create(:article, :with_translations)
    ]

    assign(:articles, articles)

    render

    en = articles.first.article_translations.find_by(lang: :en)

    expect(rendered).to match(/#{en.question}/)
    expect(rendered).to match(/#{en.answer}/)
  end
end
