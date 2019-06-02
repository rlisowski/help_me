# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print 'db:seed '

unless Article.exists?
  100.times do
    print '.'
    Article.transaction do
      article = Article.create!
      ArticleTranslation.create!(article: article,
                                 lang: :en,
                                 question: Faker::Lorem.sentence,
                                 answer: Faker::Lorem.sentence)
      ArticleTranslation.create!(article: article,
                                 lang: :de,
                                 question: Faker::Lorem.sentence,
                                 answer: Faker::Lorem.sentence)
    end
  end
end

puts ' ✅'
