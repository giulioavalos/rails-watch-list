# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

require 'faker'

# Generate fake data for movies
Movie.destroy_all
List.destroy_all
Bookmark.destroy_all

10.times do
  Movie.create!(
    title: Faker::Movie.title,
    overview: Faker::Lorem.paragraph,
    poster_url: Faker::Internet.url,
    rating: Faker::Number.between(from: 1, to: 10)
  )
end

# Generate fake data for lists
5.times do
  List.create!(
    name: Faker::Book.genre
  )
end

# Generate fake data for bookmarks
Movie.all.each do |movie|
  List.all.each do |list|
    Bookmark.create!(
      comment: Faker::Lorem.sentence,
      movie: movie,
      list: list
    )
  end
end

puts "Generated"
