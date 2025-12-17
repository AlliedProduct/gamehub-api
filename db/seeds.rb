# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
u = User.create!(email: "demo@example.com", password: "password", username: "demo")
g1 = Game.create!(title: "The Legend of Zelda: TOTK", platform: "Switch", genre: "Adventure", release_year: 2023)
g2 = Game.create!(title: "Baldur's Gate 3", platform: "PC", genre: "RPG", release_year: 2023)
u.library_items.create!(game: g1, status: "playing")
