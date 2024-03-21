require 'faker'
require 'cloudinary'
require 'open-uri'

Deal.destroy_all
Offer.destroy_all
Item.destroy_all
User.destroy_all
Category.destroy_all

# Categories
CATEGORIES = ['Electronics', 'Clothing', 'Books', 'Furniture', 'Sports Equipment', 'Home Appliances', 'Toys', 'Beauty Products']
CONDITIONS = ["new", "like new", "good", "fair", "poor"]

CATEGORIES.each do |name|
  Category.create!(name: name)
end

2.times do |time|
  puts "creating user"
  user = User.create!(email: "#{time}@mail.com", password: 'password', address: '123 Main St')
  5.times do
    puts "creating item"
    item = Item.create!(user: user, category: Category.all.sample, name: Faker::Book.title, description: Faker::Book.genre, condition: CONDITIONS.sample, address: Faker::Address.full_address)

    2.times do
      puts "creating item photoo"

      image_url = Faker::LoremFlickr.image(size: "200x200", search_terms: ['book'])
      io = URI.open(image_url)

      item.photos.attach(io:, filename: "item_#{Time.now.to_i}.jpg", content_type: 'image/jpg')
    end
  end
end
puts 'outside loop'
Item.all.each do |item|
  puts 'creating preferences for item'
  Preference.create!(item_id: item.id, category_id: Category.all.sample.id)
  Preference.create!(item_id: item.id, category_id: Category.all.sample.id)
end

User.first(10).each do |user|
    puts "creating offer"
    item = user.items.sample
    offer = Offer.new(item_id: item.id)
    offer.save!
    Item.all.sample.offers << item.offer
  user.my_offers.each do |offer|
    if [1,2].sample == 1
      puts "creating deal for offer"
      offer.deal = Deal.new status: 'accepted'
      # rand = [1, 2, 3, 4].sample
      #   puts "creating review deal for offer"
      # #   deal.update(status: 'completed')
      # #   Review.create!(user_reviewed_id: user.id, deal: deal, user_reviewer_id: Item.find(offer.requested_item_id).user.id, content: 'Smooth exchange')
      # # elsif rand == 3
      # #   deal.update(status: 'completed')
      # #   Review.create!(user_reviewed_id: Item.find(offer.requested_item_id).user.id, deal: deal, user_reviewer_id:
      # user.id, content: 'Great transaction')
      # # elsif rand == 2
      #   deal.update(status: 'completed')
      #   Review.create!(user_reviewed_id: Item.find(offer.requested_item_id).user.id, deal: deal, user_reviewer_id:
      # user.id, content: 'Great transaction')
      #   Review.create!(user_reviewed_id: user.id, deal: deal, user_reviewer_id:
      # Item.find(offer.requested_item_id).user.id, content: 'Smooth exchange')
    end
  end
end


10.times do
  chatroom = Chatroom.create
  user = User.all.sample
  Participant.create(user: user, chatroom: chatroom)
  Message.create(user: user, chatroom: chatroom, content: Faker::Quote.famous_last_words)
end
