# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 30.times do
#     Article.create(
#       title: Faker::Lorem.sentence(word_count: rand(3..10)),
#       body: Faker::Lorem.paragraph(sentence_count: rand(70..500)),
#       author: Faker::Name.name
#       )
# end

end_date = Time.now
# Define o intervalo de um mês atrás
start_date = end_date - (30 * 24 * 60 * 60)

def format_news_body(paragraph)
  formatted_body = paragraph.split("\n\n").map { |para| para.strip }.join("\n\n")
  formatted_body
end

def random_date(start_date, end_date)
  Time.at(rand(start_date.to_i..end_date.to_i))
end

[ "Everything", "Politics", "Sports", "Entertainment", "Business", "Science", "Others" ].each do |name|
  Category.find_or_create_by(name: name)
end


existing_categories = Category.all

30.times do
  Article.create(
    title: Faker::Lorem.sentence(word_count: rand(3..10)),
    body: format_news_body(Faker::Lorem.paragraph(sentence_count: rand(70..500))),
    author: Faker::Name.name,
    published_at: random_date(start_date, end_date),
    category: existing_categories.sample
  )
end
