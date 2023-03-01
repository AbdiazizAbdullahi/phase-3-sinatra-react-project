puts "🌱 Seeding spices..."

# Seed your database here

# # Create 10 users 
# 10.times do
#     User.create(
#       name: Faker::Name.name,
#       email: Faker::Internet.email,
#       password: 'fakepass',
#       phone: Faker::Number.number(digits: 9)
#     )
#   end 
  
#   # Get all users
#   users = User.all
  
#   # Create 20 cats
#   20.times do
#     Pet.create(
#       name: Faker::Creature::Cat.name,
#       breed: Faker::Creature::Cat.breed,
#       age: rand(1..20),
#       image: Faker::LoremFlickr.image(size: '300x300'),
#       user_id: users.sample.id
#     )
#   end

puts "✅ Done seeding!"
