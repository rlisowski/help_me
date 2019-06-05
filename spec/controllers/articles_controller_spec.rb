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
end
