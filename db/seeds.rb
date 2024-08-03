require 'faker'
require 'httparty'

puts "Destroying existing records..."

# Use transactions to ensure atomicity
ActiveRecord::Base.transaction do
  # Delete records in the correct order to respect foreign key constraints
  OrderItem.delete_all
  Order.delete_all
  Product.delete_all
  ProductCategory.delete_all
  User.delete_all
  Province.delete_all

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

  # Create some users
  10.times do
    User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: 'password',
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      postal_code: Faker::Address.zip_code,
      province: Province.order('RANDOM()').first,
      phone_number: Faker::PhoneNumber.phone_number
    )
  end
  puts "Creating Admin User..."

  # Check if the admin user exists before creating
  unless AdminUser.exists?(email: 'admin@example.com')
    AdminUser.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  else
    puts "Admin user with email 'admin@example.com' already exists."
  end
  
  puts "Creating Categories..."

  cat1 = ProductCategory.find_or_create_by!(name: 'Eyeshadow')
  cat2 = ProductCategory.find_or_create_by!(name: 'Cream')
  cat3 = ProductCategory.find_or_create_by!(name: 'Lipgloss')
  cat4 = ProductCategory.find_or_create_by!(name: 'Lip stick')

  def open_asset(file_name)
    File.open(Rails.root.join('db', 'seed_images', file_name))
  end

  puts "Creating Products from API..."

  # Fetch products from the Makeup API
  response = HTTParty.get('https://makeup-api.herokuapp.com/api/v1/products.json')
  products = response.parsed_response

  products.each do |product_data|
    category_name = product_data['product_type'].capitalize
    category = ProductCategory.find_or_create_by!(name: category_name)

    # Convert price to a valid float and format it to two decimal places
    price = product_data['price'].to_f
    price = [price, 0.01].max  # Ensure price is at least 0.01
    price = [price, 999999.99].min  # Ensure price is at most 999999.99
    formatted_price = sprintf('%.2f', price)  # Format to two decimal places

    begin
      category.products.create!(
        name: product_data['name'],
        description: product_data['description'] || Faker::Hipster.paragraph,
        image: product_data['image_link'],
        price: formatted_price,
        quantity: rand(1..100) # Random quantity for the sake of example
      )
      puts "Created product: #{product_data['name']} with price: #{formatted_price}"
    rescue ActiveRecord::RecordInvalid => e
      puts "Failed to create product #{product_data['name']}: #{e.message}"
    end
  end

  puts "Creating Additional Products..."

  [
    { category: cat1, name: 'Good', image: '5.jpg', price: 70.99, quantity: 10 },
    { category: cat3, name: 'Pret', image: '2.jpeg', price: 100.99, quantity: 10 },
    { category: cat2, name: 'Handy', image: '2.jpeg', price: 15.49, quantity: 16 },
    { category: cat4, name: 'Xbox', image: '9.jpeg', price: 26.00, quantity: 18 },
    { category: cat4, name: 'Mascara', image: '5.jpg', price: 20.29, quantity: 29 },
    { category: cat2, name: 'Contro', image: '8.jpeg', price: 30.00, quantity: 10 },
    { category: cat4, name: 'Ga', image: '7.jpeg', price: 70.99, quantity: 10 },
    { category: cat4, name: 'Console Ga', image: '9.jpeg', price: 3052.00, quantity: 10 },
    { category: cat4, name: 'Console', image: '7.jpeg', price: 987.65, quantity: 10 },
    { category: cat4, name: 'Lipo', image: '8.jpeg', price: 987.65, quantity: 10 },
    { category: cat4, name: 'Xbox', image: '5.jpg', price: 30.29, quantity: 40 },
    { category: cat4, name: 'Xbox 2', image: '7.jpeg', price: 80.99, quantity: 80 }
  ].each do |product_data|
    begin
      product_data[:category].products.create!(
        name: product_data[:name],
        description: Faker::Hipster.paragraph,
        image: open_asset(product_data[:image]),
        price: sprintf('%.2f', product_data[:price]),
        quantity: product_data[:quantity]
      )
      puts "Created additional product: #{product_data[:name]}"
    rescue ActiveRecord::RecordInvalid => e
      puts "Failed to create additional product #{product_data[:name]}: #{e.message}"
    end
  end
end

puts "Seeding completed successfully."
