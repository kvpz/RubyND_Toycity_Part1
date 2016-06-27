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
  puts "___Toy name: #{toy["title"]}___"

  #toy's retail price
  puts "Retail price: $#{toy["full-price"]}"

  # calculate amount of purchases for a toy
  puts "Amount of purchases: #{toy["purchases"].length}"

  #summing up all purchases to then display total sales
  sales = 0
  toy["purchases"].each do |purch|
    sales += purch["price"]
  end
  puts "Total sales: $#{sales}"

  #Calculating averagePrice and displaying it
  averagePrice = sales/toy["purchases"].length
  puts "Average price toys sold for $ #{averagePrice}"

  # I'm not sure how the total discount is wanted exactly, but...
  # I'm going to subtract the averagePrice by retail then divide
  #
  #
  totalDiscounts = (1 - averagePrice/toy["full-price"].to_f)*100
  puts "The average discount(percentage): %#{totalDiscounts.round(2)}"
  puts ""
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

#storing the JSON array sorted by brand into another array
item_array = products_hash["items"].sort_by{|i| i["brand"]}

itr = 1 #used with array 'brand' declared below
brand = Array.new(1,item_array[0]["brand"]) #stores the names of brands; initialized with first brand
itemStockByBrand = Hash.new(0) #{brand:stock}
amtOfDistinctToys = Hash.new #[brand]++ Iff brand==current_brand
brandToyPriceSum = Hash.new #[brand] = averagePrice = ALL_arr["full-price"]/amt_of_toys
totalRevenue = Hash.new #[brand] += purchases["price"]

#Gathering information
item_array.each do |item| #item is a Hash
  currentBrand = item["brand"]
  # store brand name in an array for later iterating through all brands,
  # E.g. brand[0]="LEGO", brand[1]="Nano Blocks", etc
  if !brand[itr-1].eql?(currentBrand)
    brand[itr] = currentBrand
    itr += 1
  end

  itemStockByBrand.merge!({currentBrand => item["stock"]}){|key,old,new| new + old}
  amtOfDistinctToys.merge!(currentBrand => 1){|key, old, new| old + 1}
  brandToyPriceSum.merge!(currentBrand => item["full-price"].to_f){|key,old,new| new+old}

  #summing up each toy's price it purchased
  item["purchases"].each do |purchase|
    totalRevenue.merge!(currentBrand => purchase["price"]){|key,old,new| old + new}
  end
end

#Displaying information
brand.each do |current|
  puts "~~~ "+current+" ~~~"
  puts "Current toys stocked: "+itemStockByBrand[current].to_s
  puts "Average price of toys: $#{(brandToyPriceSum[current]/amtOfDistinctToys[current]).round(2)} (out of #{amtOfDistinctToys[current]} distinct toys)"
  puts "Toy sales combined: $#{+totalRevenue[current].round(2)}"
  print "\n"
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