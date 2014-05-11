class MoneyCalculator
	#attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands
	attr_accessor :received
	#attr_accessor :cost

	def change(cost)
		if cost.to_i > received.to_i
			return {}
		else
			moneyback = received.to_i - cost.to_i
			grand = moneyback/1000
			halfgrand = (moneyback%1000)/500
			tenth = ((moneyback%1000)%500)/100
			halftenth = (((moneyback%1000)%500)%100)/50
			twentieth = ((((moneyback%1000)%500)%100)%50)/20
			halftwentieth = (((((moneyback%1000)%500)%100)%50)%20)/10
			fifth = ((((((moneyback%1000)%500)%100)%50)%20)%10)/5
			singles = ((((((moneyback%1000)%500)%100)%50)%20)%10)%5
			return {:ones => singles, :fives => fifth, :tens => halftwentieth, :twenties => twentieth, :fifties => halftenth, :hundreds => tenth, :five_hundreds => halfgrand, :thousands => grand, :totalchange => moneyback}
		end
	end

  	def initialize(thousands, five_hundreds, hundreds, fifties, twenties, tens, fives, ones)
    	self.received = (ones.to_i + (fives.to_i*5) + (tens.to_i*10) + (twenties.to_i*20) + (fifties.to_i*50) + (hundreds.to_i*100) + (five_hundreds.to_i*500) + (thousands.to_i*1000))
  	end
end

# each parameter represents the quantity per denomination of money
# these parameters can be assigned to instance variables and used for computation

# add a method called 'change' that takes in a parameter of how much an item costs
# and returns a hash of how much change is to be given
# the hash will use the denominations as keys and the amount per denomination as values
# i.e. {:fives => 1, fifties => 1, :hundreds => 3}