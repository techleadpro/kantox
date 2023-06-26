class Product

attr_accessor :code, :name ,:price

	def initialize(code, name, price)
	@code= code
	@name = name
	@price = price

	end
	
	
	def display()
		puts "Product Code: " + @code.to_s
		puts "Name: " + @name.to_s
		puts "Price: " + @price
		puts "\n\n"
	end
	
	

end
