require 'faker'
require 'cloudinary'
require 'open-uri'

Message.destroy_all
Participant.destroy_all
Chatroom.destroy_all
Deal.destroy_all
Offer.destroy_all
Item.destroy_all
User.destroy_all
Category.destroy_all

# Categories
CATEGORIES = [
  "Electrónica",
  "Hogar y Jardín",
  "Moda y Accesorios",
  "Deportes y Fitness",
  "Juguetes y Bebés",
  "Salud y Belleza",
  "Electrodomésticos",
  "Herramientas y Construcción",
  "Muebles y Decoración",
  "Automotriz",
  "Libros, Revistas y Comics",
  "Arte y Antigüedades",
  "Instrumentos Musicales",
  "Videojuegos y Consolas",
  "Computación",
  "Alimentos y Bebidas",
  "Telefonía y Accesorios",
  "Cámaras y Accesorios",
  "Relojes y Joyas",
  "Equipamiento para Industrias y Oficinas",
  "Equipaje y Bolsos",
  "Animales y Mascotas",
  "Coleccionables",
  "Bicicletas y Ciclismo",
  "Instrumentos Ópticos y Fotografía",
  "Arte, Papelería y Mercería",
  "Entradas para Eventos",
  "Sellos",
  "Souvenirs, Cotillón y Fiestas",
  "Otras categorías"
]
CONDITIONS = ["Excelente", "Bueno", "Regular", "Aceptable", "Dañado"]

CATEGORIES.each do |name|
  Category.create!(name: name)
end

5.times do |time|
  puts "creating user"
  user = User.create!(email: "#{time}@mail.com", password: 'password', address: '123 Main St')
  4.times do
    puts "creating item"
    item = Item.create!(user: user, category: Category.all.sample, name: Faker::Book.title, description: Faker::Book.genre, condition: CONDITIONS.sample, address: 'aeroparque, buenos aires')

    1.times do
      puts "creating item photoo"

      image_url = Faker::LoremFlickr.image(size: "200x200", search_terms: ['book'])
      io = URI.open(image_url)

      item.photos.attach(io:, filename: "item_#{Time.now.to_i}.jpg", content_type: 'image/jpg')
    end
  end
end
puts 'outside loop'
User.all.each do |user|
  puts 'creating preferences for item'

  Preference.create!(user_id: user.id, category_id: Category.all.sample.id)
  Preference.create!(user_id: user.id, category_id: Category.all.sample.id)
  Preference.create!(user_id: user.id, category_id: Category.all.sample.id)

  puts "Creating offer for user #{user.id}"
  # Get IDs of items owned by other users
  other_users_items_ids = Item.where.not(user_id: user.id).pluck(:id)

  # Select a random item ID from the items owned by other users
  requested_item_id = other_users_items_ids.sample

  # Select a random item ID from the user's own items
  offered_item_id = user.items.pluck(:id).sample

  # Create the offer
  Offer.create(requested_item_id: requested_item_id, offered_item_id: offered_item_id)
end
Offer.all.each do |offer|
  if [1,2].sample == 1
    puts "creating deal for offer"
    Deal.create!(status: 'accepted', offer_id: offer.id)
  end
end

8.times do
  chatroom = Chatroom.create
  users = User.all.sample(2)
  users = User.all.sample(2) while Chatroom.between(users)
  chatroom.users = users
  Message.create(user: users.first, chatroom: chatroom, content: Faker::Quote.famous_last_words)
  Message.create(user: users.last, chatroom: chatroom, content: Faker::Quote.famous_last_words)
end
