# frozen_string_literal: true

class Translator
  def call
    article_de.update(
      question: translate(article_en.question),
      answer: translate(article_en.answer)
    )
    ArticlesChannel.broadcast_to('articles', article_id: article_id)
  end

  private

  attr_reader :article_id

  def initialize(article_id)
    @article_id = article_id
  end

  def article_en
    @article_en ||= Article
                    .find(article_id)
                    .article_translations
                    .find_by(lang: :en)
  end

  def article_de
    @article_de ||= Article
                    .find(article_id)
                    .article_translations
                    .find_by(lang: :de)
  end

  def translate(text)
    Translator::MicrosoftTranslator.new.call(text)
  end
end
