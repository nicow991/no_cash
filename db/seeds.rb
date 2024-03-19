require 'faker'
require 'cloudinary'
require 'open-uri'

# Categories
CATEGORIES = ['Electronics', 'Clothing', 'Books', 'Furniture', 'Sports Equipment', 'Home Appliances', 'Toys', 'Beauty Products']
CONDITIONS = ["new", "like new", "good", "fair", "poor"]

CATEGORIES.each do |name|
  Category.create(name: name)
end

# Deals
Offer.all.each do |offer|
  Deal.create(offer_id: offer.id, status: 'accepted')
end

# Participants
Participant.create(user_id: 1, chatroom_id: 1)
Participant.create(user_id: 2, chatroom_id: 1)




20.times do |time|
  user = User.create(email: "#{time}@mail.com", password: 'password', address: '123 Main St')
  rand(0..15).times do
    Item.create(user: user, category: Category.all.sample, name: Faker::Book.title, description: Faker::Book.genre, condition: CONDITIONS.sample)
  end
end

2.times do
  image_url = Faker::LoremFlickr.image(size: "200x200", search_terms: ['book'])
  io = URI.open(image_url)

  boat.photos.attach(io:, filename: "boat_#{Time.now.to_i}.jpg", content_type: 'image/jpg')
end

10.times do
  User.first(10).each do |user|
    2.times do |time|
      Offer.create(offered_item_id: user.items.pluck(:id).sample, requested_item: Item.where.not(user: user).sample)
    end
    offer.each do |offer|
      if [1,2].sample == 1
        deal = Deal.create(offer_id: offer.id, status: 'accepted')
        rand = [1, 2, 3].sample
        if rand == 1
          Review.create(user_reviewed: user, deal: deal, user_reviewer: offer.requested_item.user, content: 'Smooth exchange')
        elsif rand == 1
          Review.create(user_reviewed: offer.requested_item.user, deal: deal, user_reviewer: user, content: 'Great transaction')
        else
          Review.create(user_reviewed: offer.requested_item.user, deal: deal, user_reviewer: user, content: 'Great transaction')
          Review.create(user_reviewed: user, deal: deal, user_reviewer: offer.requested_item.user, content: 'Smooth exchange')
        end
      end

    end
  end
end
