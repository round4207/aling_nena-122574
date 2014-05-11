require 'sinatra'
require './money_calculator.rb'

get '/' do
	cost = 314
	item = MoneyCalculator.new(0, 0, 0, 0, 0, 0, 0, 1)
	change_list = [:thousands, :five_hundreds, :hundreds, :fifties, :twenties, :tens, :fives, :ones]
	change_grammar = {:thousands => "thousand peso bill/s", :five_hundreds => "five hundred peso bill/s", :hundreds => "hundred peso bill/s", :fifties => "fifty peso bill/s", :twenties => "twenty peso bill/s", :tens => "ten peso coin/s", :fives => "five peso coin/s", :ones => "one peso coin/s"}
	change_list.each do |x|
		if item.change(cost)[x] != 0
			puts "#{item.change(cost)[x]} #{change_grammar[x]}"
		end
	end
	#"#{item.change(1300)[:thousands]} #{item.change(1300)[:five_hundreds]} #{item.change(1300)[:hundreds]} #{item.change(1300)[:fifties]} #{item.change(1300)[:twenties]} #{item.change(1300)[:tens]} #{item.change(1300)[:fives]} #{item.change(1300)[:ones]}"
end