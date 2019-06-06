# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print 'db:seed '

Article.destroy_all

faq_file = File.open(Rails.root.join('FAQ.md'), 'w+')

faq = [
  'Why you using _docker-compose_ for development?',
  'I usually don\'t but this time I decided to isolate the dev environment.',

  'Why an asynchronous worker translates to German in the background?',
  'The translation is done automatically by external service.
   I want to keep the app up and running even if the service is down or the quota is exceeded.',

  'Why the length of questions and answers is limited?',
  'I\'m using a free version of [Translator Text API](https://azure.microsoft.com/en-us/services/cognitive-services/translator-text-api/).
   I didn\'t want to hit quota too early.',

  'Why UUIDs?',
  'In task description is written than I should assume high traffic.
   In such scenario it\'s very likely that you have HA architecture like master-master synchronization.
   UUIDs generates less collisions than standard numeric primary keys so that synchronization would be easier.',

  'Why there is FactoryBot?',
  'FactoryBot is very popular and it makes life so much easier.',

  'ERB?',
  'I used to use slim or haml but also I try to keep things simple. This is true especially for small projects.',

  'Why Zurb Foundaiton and not Twitter Bootstrap?',
  'For me it\'s equally evil.
   I needed something that makes site "prettier" and in my opinion,
   Zurb Foundaiton is easier to set up and remove later.'
]

faq.each_slice(2) do |question, formatted_answer|
  print '.'
  Article.transaction do
    answer = formatted_answer.gsub(/\s+/, ' ')
    article = Article.create!
    ArticleTranslation.create!(article: article,
                               lang: :en,
                               question: question,
                               answer: answer)
    ArticleTranslation.create!(article: article,
                               lang: :de,
                               question: 'Übersetzung in Bearbeitung',
                               answer: 'Übersetzung in Bearbeitung')

    TranslateArticleJob.perform_now(article.id)
    faq_file.write "* Q: #{question}\n"
    faq_file.write "* A: #{answer}\n"
    faq_file.write "\n\n"
  end
end

faq_file.close

puts ' ✅'
