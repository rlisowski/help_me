# frozen_string_literal: true

class ArticleTranslation < ApplicationRecord
  belongs_to :article, touch: true

  enum lang: %i[en de]

  validates :question, :answer, length: { maximum: 256 }
  validates :question, :answer, presence: { if: :en? }
  validates :lang, uniqueness: { scope: :article_id }

  validates :question, presence: { if: :answer }
  validates :answer, presence: { if: :question }
end
