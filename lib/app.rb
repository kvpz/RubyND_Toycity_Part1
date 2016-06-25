require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "

puts Time.new
print "\n"

# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

products_hash["items"].each do |toy|
  #print name of toy
  puts toy["title"]

  #toy's retail price
  puts 'retail price: $'+toy["full-price"]

  # calculate amount of purchases for a toy
  puts toy["purchases"].length

  #summing up all purchases to then display total sales
  sales = 0
  toy["purchases"].each do |purch|
    sales += purch["price"]
  end
  print "total sales: $"
  puts sales

  #Calculating averagePrice and displaying it
  print "Average price toys sold for $"
  averagePrice = sales/toy["purchases"].length
  puts averagePrice

  # I'm not sure how the total discount is wanted exactly, but...
  # I'm going to subtract the averagePrice by retail then divide
  #
  #
  totalDiscounts = (1 - averagePrice/toy["full-price"].to_i)*100
  print "The average discount(percentage): %"
  puts totalDiscounts
  puts
end

puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts ""

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined
print "\n\n"

#store the JSON array sorted by brand into another array
arr = products_hash["items"].sort_by{|i| i["brand"]}

brand = arr[0]["brand"]
previousBrand = arr[0]["brand"]
totalStock = 0
averagePrice = 0
puts brand
arr.each do |i|
  brand = i["brand"]
  #Print the name of the brand

  #Counting then printing the amount of the brand's toys in stock
  totalStock = i["stock"]
  if previousBrand.eql?(brand)
    totalStock += i["stock"]
    puts totalStock
  else
    print brand
    puts totalStock
    totalStock = i["stock"]
    print ' '
  end
end



=begin
toy["purchases"].each do |purch|
  currentSalePrice = purch["price"]
  if currentSalePrice < averagePrice
    totalDiscounts +=currentSalePrice
  else
    totalDiscounts -= currentSalePrice
  end
end
=end