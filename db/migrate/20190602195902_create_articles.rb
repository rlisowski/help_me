class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles, id: :uuid do |t|
      # article is a container for all related articles translations
      t.timestamps
    end
  end
end
