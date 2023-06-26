require 'date'
require 'time'
require 'json'
#require 'espeak'

require_relative 'product.rb'

class Checkout

attr_reader :order

def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @cart = []
    @order = []
end



def scan(item) 

file1 = File.read('orders.json')

@order =JSON.parse(file1)


         case item
	 	when "GR1"
	 	 @order.push({"product code" => "GR1", "name" => "Green tea", "price" => 3.11})
	 	when "SR1"
	 	 @order.push({"product code" => "SR1", "name" => "Strawberries", "price" => 5.00})
		when "CF1"
		 @order.push({"product code" => "CF1", "name" => "Coffee", "price" => 11.23})
		else
		 	puts "The "+item+ "is not available"
	    end
      
     

     open('orders.json', 'w') do |file|
        file.puts @order.to_json
     end
end


def total1
file1 = File.read('orders.json')

items =JSON.parse(file1)
total = 0

i=0

while i < items.length
total += items[i]["price"]
i+=1
end

return puts total.round(2)

end



def greenTeaDisc (gR1Number, totCost, prodPrice)
	if gR1Number % 2 != 0
		totCostGR1 = (gR1Number - 1) * prodPrice
		totCostGR1Sub = totCostGR1 / 2 
		diff = totCostGR1 - totCostGR1Sub
		totCost -= diff
		totCost.round(2)
	else
		totCostGR1 = gR1Number * prodPrice
		totCostGR1Sub = totCostGR1 / 2
		diff = totCostGR1 - totCostGR1Sub
		totCost -= diff
		totCost.round(2)
	end	
	
end
	
	
	
def strawBerryDisc(sR1Number, totCost)
	if sR1Number >= 3
		totCost -= (sR1Number * 0.50)
		totCost.round(2)
	end
		totCost.round(2)
end
	
	
def coffeeDisc(cF1Number, totCost, prodPrice)
 	if cF1Number >= 3
 		totCostCF1 = cF1Number * prodPrice
 		disc = totCostCF1 * 2 /3
 		diff = totCostCF1 - disc
 		totCost -= diff
		totCost.round(2)
 	end
 	totCost.round(2)
end

def getProdPrice
	@order.each_with_object({}) do |item, products|
		products[item["product code"]] = item["price"]
	end
end


def total	
@totCost = @order.map {|item| item["price"]}.reduce(:+)
@prodPrice = getProdPrice	
    case @pricing_rules
	when "CEO_conditions"
	@gR1Number = @order.count {|i| i["product code"] == "GR1"}
	greenTeaDisc(@gR1Number, @totCost, @prodPrice['GR1'])
	when "COO_conditions"
	@sR1Number = @order.count {|i| i["product code"] == "SR1"}
	strawBerryDisc(@sR1Number, @totCost)
	when "CTO_conditions"
	@cF1Number = @order.count {|i| i["product code"] == "CF1"}
	coffeeDisc(@cF1Number, @totCost, @prodPrice['CF1'])
       end
end



def add

end


def load_data

data =[
{"product code" => "GR1", "name" => "Green tea", "price" => 3.11},
{"product code" => "SR1", "name" => "Strawberries", "price" => 5.00},
{"product code" => "CF1", "name" => "Coffee", "price" => 11.23}
]

puts "Data has been loaded from file"


####SAVE####
## File has been changed to json to make it easier to load and convert directly
### how to save hash in a file .json
open('data.json', 'w') do |file|
    file.puts data.to_json
    
end
dashboard1

end

def dashboard

today_date = Date.today
today = today_date.to_s
 #######################################################################################################################

puts "Please choose (1) to enter (Dashboad) or (2) to exit:"


puts "\n1) Dashboard 2) Exit or (q) to quit\t\t (Please choose 1 or 2):"

choice = gets.chomp


case choice
 when "1" 
 puts "(Selected) Enter Dashboard"
 puts "\n\n"
 re = Checkout.new("CEO_conditions")
 re.dashboard1
 
 when "2" then
 puts "\n\nExiting program. Thank you please come again! \tTodays Date: #{today_date}: \n\n "
 ##exiting = "Exiting program. Thank you please come again!"

 # Speaks "YO!"
 ##text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
 ##text1.speak # invokes espeak
      exit
 when "quit"
 puts "\n\nExiting program. Thank you please come again! \tTodays Date: #{today_date}: \n\n " 
###exiting = "Exiting program. Thank you please come again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak
 
     exit
 when "q"
 puts "\n\nExiting program. Thank you please come again! \tTodays Date: #{today_date}: \n\n "

###exiting = "Exiting program. Thank you please come again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

      exit     
 when "e"
 puts "\n\nExiting program. Thank you please come again! \tTodays Date: #{today_date}: \n\n "
###exiting = "Exiting program. Thank you please come again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

      exit
 else puts "\n\n\nOpps! Please try again..\n\n\n"
again = "Oops! Please try again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{again}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

   re = Checkout.new("CEO_conditions")
   re.dashboard1
end

end



def dashboard1
 
today_date = Date.today
today = today_date.to_s
 #######################################################################################################################


puts "Please enter (1 or 2 or 3) to select options from the following"


puts "\n1) Add Item \n2) List Item \n3) Load JSON Data. \n4) Exit or (quit)\t\t Todays Date is #{today_date}: \n\n (Please choose 1 or 2 or 3):"

###text = "Please enter 1 or 2 or 3.  1 To add new item, 2 to list items and 3 to load j son data. You can exit by pressing q to exit."
# text3 = "Please enter 1 or 2 or 3.  To add new record, list record and load data."
# Speaks "YO!"
###text2 = ESpeak::Speech.new("#{text}", voice: "mb-en1", pitch: 90, speed: 130)
###text2.speak # invokes espeak

choice = gets.chomp


case choice
 when "1" 
 puts "(Selected) Add Record"
 puts "\n\n"
 cr = Schedule.new
 cr.add
 
 when "2" 
 puts "(Selected) List Record"
 puts "\n\n"
 li = Schedule.new
 li.show
 
 when "3" 
 puts "(Selected) Load Data"
 puts "\n\n"
 lo = Checkout.new
 lo.load_data
 when "4" then
 puts "Exiting program. Thank you please come again!"
 ###exiting = "Exiting program. Thank you please come again!"

 # Speaks "YO!"
 ###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
 ###text1.speak # invokes espeak
      exit
 when "quit"
 puts "Exiting program. Thank you please come again!" 
###exiting = "Exiting program. Thank you please come again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak
 
     exit
 when "q"
 puts "Exiting program. Thank you please come again!" 
###exiting = "Exiting program. Thank you please come again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

      exit     
 when "e"
 puts "Exiting program. Thank you please come again!" 
###exiting = "Exiting program. Thank you please come again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{exiting}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

      exit
 else puts "\n\n\nOpps! Please try again..\n\n\n"
###again = "Oops! Please try again!"

# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{again}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

   re = Checkout.new("CEO_conditions")
   re.dashboard1
end

end

end




#########################################################################
### how to save hash in a file .json
#open('items.json', 'w') do |file|
#    file.puts $items_store.to_json
    
#end
###

file = File.read("items.json")
data_hash = JSON.parse(file)
data_keys = []

#########################################################################
# Speaks "YO!"
###speech = ESpeak::Speech.new("Welcome to the Kantox store", voice: "mb-en1", pitch: 90, speed: 130)
###speech.speak # invokes espeak


today_date = Date.today
today = today_date.to_s

puts "------------------Online Shop - Technical Evaluation-------------------"


puts "--- --- --- -- --- --- --- --- --- -- --- -- -- -- -- -- -- -- -- -- --"
puts "                    Welcome to Kantox Online Shop.           #{today}"
puts "\nList of types of items in the store:"
puts "  Product code \t|Name \t\t\t|\tPrice"

itemlist = "" 
i=0
while i < 3
puts "#{i+1})"+data_hash[i]["product code"]+" \t\t "+data_hash[i]["name"]+"\t\t\t ​£"+data_hash[i]["price"].to_s.chomp+" "
itemlist << " "+ data_hash[i]["name"]+" "
i+=1

end
####################################################
puts "\n\n"
puts "--- --- --- -- --- --- --- --- --- -- --- -- --- -- -- -- -- -- --"


text = "Today is #{today}. These are the items in the store."
puts text
# Speaks "YO!"
###text1 = ESpeak::Speech.new("#{text}", voice: "mb-en1", pitch: 90, speed: 130)
###text1.speak # invokes espeak

# Speaks "YO!"
###text2 = ESpeak::Speech.new("#{itemlist}", voice: "mb-en1", pitch: 90, speed: 130)
###text2.speak # invokes espeak



##p1 = Checkout.new(pricing_rules)

pricing_rules = "CEO_conditions"

co = Checkout.new(pricing_rules)
co.scan("GR1")
co.scan("GR1")

price = co.total
puts "Previous ORDER Total: "+price.to_s

file1 = File.read('orders.json')

basket =JSON.parse(file1)


##b1=basket.each{|i| print i","}
data_keys = ""
i=0
while i < basket.length
data_keys << basket[i]["product code"]+" "
i+=1
end


puts "All check items scanned"
puts "--- --- --- -- --- --- --- --- --- -- --- -- --- -- -- -- -- -- --"

puts "\n\nWe scanned "+data_keys+"items.\n\n\n"
puts "Test data:"
puts "Basket "+data_keys
puts "Total price expected: ​£#{price}"
puts "--- --- --- -- --- --- --- --- --- -- --- -- --- -- -- -- -- -- --"

#puts "#{@order}"
co.dashboard


