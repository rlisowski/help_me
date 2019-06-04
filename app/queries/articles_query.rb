# frozen_string_literal: true

class ArticlesQuery
  def call
    initial_scope.includes(:article_translations)
  end

  private

  attr_reader :initial_scope

  def initialize(initial_scope: Article.all)
    @initial_scope = initial_scope
  end
end
