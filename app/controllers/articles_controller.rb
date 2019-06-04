# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = ArticlesQuery.new.call
  end
end
