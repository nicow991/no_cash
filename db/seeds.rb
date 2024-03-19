# Categories
Category.create(name: 'Electronics')
Category.create(name: 'Clothing')
Category.create(name: 'Books')
Category.create(name: 'Furniture')
Category.create(name: 'Sports Equipment')
Category.create(name: 'Home Appliances')
Category.create(name: 'Toys')
Category.create(name: 'Beauty Products')
# Users
User.create(email: 'user1@example.com', password: 'password', address: '123 Main St')
User.create(email: 'user2@example.com', password: 'password', address: '456 Elm St')

# Items
Item.create(user_id: 1, category_id: 1, name: 'Laptop', description: 'Brand new laptop', condition: 'New')
Item.create(user_id: 1, category_id: 2, name: 'Camiseta', description: 'Camiseta azul', condition: 'Used')
Item.create(user_id: 2, category_id: 3, name: 'Harry Potter', description: 'Book by J.K. Rowling', condition: 'Like new')
Item.create(user_id: 1, category_id: 1, name: 'Raqueta de tenis', description: 'Nueva', condition: 'New')
Item.create(user_id: 1, category_id: 2, name: 'Skies', description: 'Bien flama, ideal para fuera de pista', condition: 'Used')
Item.create(user_id: 2, category_id: 3, name: 'El senor de los anillos', description: 'Book by Tolkien, incredible', condition: 'Like new')

# Chatrooms
Chatroom.create
Chatroom.create

# Messages
Message.create(chatroom_id: 1, user_id: 1)
Message.create(chatroom_id: 1, user_id: 2)

# Offers
Offer.create(offered_item_id: 1, requested_item_id: 3)
Offer.create(offered_item_id: 2, requested_item_id: 3)

# Deals
Offer.all.each do |offer|
  Deal.create(offer_id: offer.id, status: 'accepted')
end

# Participants
Participant.create(user_id: 1, chatroom_id: 1)
Participant.create(user_id: 2, chatroom_id: 1)

# Reviews
Review.create(user_reviewed_id: 2, deal_id: 1, user_reviewer_id: 1, content: 'Great transaction')
Review.create(user_reviewed_id: 1, deal_id: 2, user_reviewer_id: 2, content: 'Smooth exchange')
