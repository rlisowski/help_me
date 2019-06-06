# frozen_string_literal: true

class TranslateArticleJob < ApplicationJob
  queue_as :default

  def perform(article_id)
    Translator.new(article_id).call
  end
end
