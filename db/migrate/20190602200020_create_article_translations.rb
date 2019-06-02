class CreateArticleTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :article_translations, id: :uuid do |t|
      t.references :article, foreign_key: true, type: :uuid
      t.integer :lang
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
