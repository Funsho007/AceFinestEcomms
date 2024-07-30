ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")

require 'faker'

puts "Destroying existing records..."

# Use transactions to ensure atomicity
ActiveRecord::Base.transaction do
  # Destroy all existing products to avoid foreign key constraint issues
  Product.destroy_all
  User.destroy_all
  ProductCategory.destroy_all
  Province.destroy_all

  puts "Creating Provinces..."

provinces = [
  { name: 'Ontario', abbreviation: 'ON' },
  { name: 'Quebec', abbreviation: 'QC' },
  { name: 'British Columbia', abbreviation: 'BC' },
  { name: 'Alberta', abbreviation: 'AB' },
  { name: 'Manitoba', abbreviation: 'MB' },
  { name: 'New Brunswick', abbreviation: 'NB' },
  { name: 'Newfoundland and Labrador', abbreviation: 'NL' },
  { name: 'Nova Scotia', abbreviation: 'NS' },
  { name: 'Prince Edward Island', abbreviation: 'PE' },
  { name: 'Saskatchewan', abbreviation: 'SK' },
  { name: 'Northwest Territories', abbreviation: 'NT' },
  { name: 'Nunavut', abbreviation: 'NU' },
  { name: 'Yukon', abbreviation: 'YT' }
]

provinces.each do |province|
  Province.find_or_create_by!(name: province[:name], abbreviation: province[:abbreviation])
end

puts "Creating Users..."

  # Assuming you want to create some users
  10.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: 'password',
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      postal_code: Faker::Address.zip_code,
      province: Province.order('RANDOM()').first # Assign a random province
    )
  end


  puts "Game Categories Creation ..."
  cat1 = ProductCategory.find_or_create_by! name: 'Game Products'
  cat2 = ProductCategory.find_or_create_by! name: 'Playstations'
  cat3 = ProductCategory.find_or_create_by! name: 'Xboxes'
  cat4 = ProductCategory.find_or_create_by! name: 'Cables and wire'

  def open_asset(file_name)
    File.open(Rails.root.join('db', 'seed_images', file_name))
  end

  puts "Products Creation ..."

  cat1.products.create!({
                          name:  'Xbox Wireless Controller',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('5.jpg'),
                          price: 70.99,
                          quantity: 10
                        })

  cat3.products.create!({
                          name:  'Playstation Controller',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('2.jpeg'),
                          price: 100.99,
                          quantity: 10
                        })


  cat2.products.create!({
                          name:  "Playstation",
                          description: Faker::Hipster.paragraph,
                          image: open_asset('2.jpeg'),
                          quantity: 16,
                          price: 15.49
                        })

  cat4.products.create!({
                          name:  'Xbox',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('9.jpeg'),
                          quantity: 18,
                          price: 26.00
                        })

  cat4.products.create!({
                          name:  'Console',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('5.jpg'),
                          quantity: 29,
                          price: 200.29
                        })
  cat2.products.create!({
                          name:  'Controller',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('8.jpeg'),
                          quantity: 10,
                          price: 30.00
                        })
  cat4.products.create!({
                          name:  'Game',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('7.jpeg'),
                          quantity: 10,
                          price: 70.99
                        })

  cat4.products.create!({
                          name:  'Console Game 1',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('9.jpeg'),
                          price: 3_052.00,
                          quantity: 10
                        })

  cat4.products.create!({
                          name:  'Console Game 2',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('7.jpeg'),
                          price: 987.65,
                          quantity: 10
                        })
  cat4.products.create!({
                          name:  'Playstation 3',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('8.jpeg'),
                          price: 987.65,
                          quantity: 10
                        })
  cat4.products.create!({
                          name:  'Xbox Wire',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('5.jpg'),
                          price: 300.29,
                          quantity: 40
                        })
  cat4.products.create!({
                          name:  'Xbox 2',
                          description: Faker::Hipster.paragraph,
                          image: open_asset('7.jpeg'),
                          price: 800.99,
                          quantity: 80
                        }) # <--- This is the line that was missing a closing bracket
end

ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")
puts "Seeding completed successfully."
