# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @article_translation = ArticleTranslation.new
    @articles = ArticlesQuery.new.call
  end

  def edit
    @article_translation = Article.find(params[:id]).article_translations.find_by(lang: :en)
  end

  def update
    article = Article.find(params[:id])
    @article_translation = article.article_translations.find_by(lang: :en)
    if @article_translation.update(article_params)
      TranslateArticleJob.set(wait: 3.seconds).perform_later(article.id)
      redirect_to articles_path, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    create_article

    respond_to do |format|
      format.html do
        if @article.persisted?
          redirect_to articles_path, notice: 'Article was successfully created.'
        else
          render :edit, status: :unprocessable_entity
        end
      end
      format.js {}
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html do
        redirect_to articles_path, notice: 'Article was successfully removed.'
      end
      format.js {}
    end
  end

  def show
    @article = Article.find(params[:id])

    render layout: !request.xhr?
  end

  private

  def create_article
    @article = Article.new
    @article_translation = @article.article_translations.build(article_params.merge(lang: :en))
    return unless @article.save

    create_empty_german_translation
    TranslateArticleJob.perform_later(@article.id)
  end

  def article_params
    params.require(:article_translation).permit(:question, :answer)
  end

  def create_empty_german_translation
    ArticleTranslation.create!(article: @article,
                               lang: :de,
                               question: 'Übersetzung in Bearbeitung',
                               answer: 'Übersetzung in Bearbeitung')
  end
end
