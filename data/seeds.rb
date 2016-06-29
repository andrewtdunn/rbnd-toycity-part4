require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  # Your code goes here!
  100.times do
     Product.create( brand: Faker::Company.name,
                               name: Faker::StarWars.character,
                               price: Faker::Commerce.price )
   end
end
