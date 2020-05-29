# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
require 'pry'
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Open URI configuration
require 'open-uri'
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

caipirinha = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590773560/public-folder/caipirinha.jpg", "Caipirinha"]
irish = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590773560/public-folder/irish.jpg", "Irish Coffee"]
milene = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590778756/public-folder/milene.jpg", "The Milene Special!"]
andre = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590778976/public-folder/andre.jpg", "Andre's Breakfast for Champions"]
margarita = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590773560/public-folder/photo-1557765086-a73d2dc3059e.jpg", "Margarita"]
whisky = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590774024/public-folder/photo-1571104508999-893933ded431.jpg", "Whisky Sour"]
campari = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590774011/public-folder/campari.jpg", "Campari Spritz"]
mojito = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590774011/public-folder/mojito.jpg", "Mojito"]
matheus = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590778839/public-folder/matheus.jpg", "The Mythesão"]
orange = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590774011/public-folder/orange.jpg", "Perfect Orange"]
gin = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590774011/public-folder/gin.jpg", "Gin & Tonic"]
isa = ["https://res.cloudinary.com/dlatcqlhm/image/upload/v1590779042/public-folder/photo-1464593745417-e22a78ca277b.jpg", "Isa's drink for lunch!"]

cocktails = [caipirinha, irish, milene, margarita, andre, whisky, matheus, campari, mojito, orange, gin, isa]

review_content = ["Delicious!", "Easy to make and drink", "Hate it x_x", "Not for my taste", "Could be better if it had more Whisky", "Needs more sugar", "Perfect for lazy Sundays!", "One of my all time favorites!", "This stuff ir horrible!", "Pure bliss"]

descriptions = ["1 ounce", "100ml", "As much as you can", "1 table spoon", "Pour an entire bottle", "just one drop", "Up to you, really", "50ml", "100ml", "50gr"]

puts "Destroy Cocktails"
Cocktail.destroy_all if Rails.env.development?

puts "Destroy ingredients"
Ingredient.destroy_all if Rails.env.development?


puts "Creating Ingredients"
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients = JSON.parse(open(url).read)

ingredients["drinks"].each do |ingredient|
  i = Ingredient.create(name: ingredient["strIngredient1"])
  puts "created: #{i.name}"
end

puts "Creating Cachaça"
Ingredient.create(name: "Cachaça")


puts "Creating Cocktails"

cocktails.each do |cocktail_data|
  cocktail = Cocktail.create!(name: cocktail_data[1])
  filename = File.basename(URI.parse(cocktail_data[0]).path)
  file = URI.open(cocktail_data[0])
  cocktail.photo.attach(io: file, filename: filename)
  cocktail.save!

  puts "creating reviews for the cocktail"

  rand(1..8).times do
    Review.create(cocktail: cocktail, content: review_content.sample, rating: rand(1..5))
  end

  puts "creating doses for the cocktail"

  rand(2..5).times do
    dose = Dose.new(cocktail: cocktail, ingredient: Ingredient.all.sample, description: descriptions.sample)
    dose.save
  end

end




