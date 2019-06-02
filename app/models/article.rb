# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :article_translations, dependent: :destroy, index_errors: true

  accepts_nested_attributes_for :article_translations
end
