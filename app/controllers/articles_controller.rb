# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    selected_lang = params[:lang] || 'en'
    @articles = Article.includes(:article_translations).where(article_translations: { lang: selected_lang })
  end
end
