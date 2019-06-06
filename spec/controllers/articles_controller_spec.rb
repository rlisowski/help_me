# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates new article with EN translation' do
      expect do
        post :create, params: { article_translation: { question: 'Doh?', answer: ':)' } }
      end.to change(Article, :count).by 1

      expect(response).to have_http_status(:redirect)
    end

    it 'complains about missing attribute' do
      expect do
        post :create, params: { article_translation: { question: '', answer: '' } }
      end.not_to change(Article, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #edit' do
    let!(:article) { create(:article_translation, lang: :en).article }

    it 'returns http success' do
      get :edit, params: { id: article.id }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    let!(:article) { create(:article) }
    let!(:en_article) do
      create(:article_translation,
             lang: :en,
             article: article,
             question: 'Why?',
             answer: 'For fun!')
    end

    it 'updates the article' do
      patch :update, params: { id: article.id, article_translation: { question: 'Doh?', answer: ':)' } }

      expect(response).to have_http_status(:redirect)

      en_article.reload
      expect(en_article.question).to eq('Doh?')
      expect(en_article.answer).to eq(':)')
    end

    it 'complains about missing attribute' do
      patch :create, params: { id: article.id, article_translation: { question: '', answer: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { create(:article_translation, lang: :en).article }

    it 'returns http success' do
      expect do
        expect do
          get :destroy, params: { id: article.id }
        end.to change(ArticleTranslation, :count).by(-1)
      end.to change(Article, :count).by(-1)

      expect(response).to have_http_status(:redirect)
    end
  end
end
