require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
  Item.create!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
    sold: 0
  )
  redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION

# PUBLIC SECTION
get '/' do
  @products = Item.all
  @display = @products.sample(10)
  erb :home
end

get '/about' do
  erb :about
end

get '/products' do
  @products = Item.all
  erb :products
end

get '/purchase/:id' do
  @product = Item.find(params[:id])
  erb :purchase
end

post '/results/:id' do
  @product = Item.find(params[:id])
  @cost = params[:quantity].to_i*@product.price
  @calc = MoneyCalculator.new(params[:thousands], params[:five_hundreds], params[:hundreds], params[:fifties], params[:twenties], params[:tens], params[:fives], params[:ones])
  poopy = @calc.change(@cost)
  if poopy == {} || params[:quantity].to_i > @product.quantity
    puts "###Quantity ordered: #{params[:quantity]} Cost: #{@cost} Received: #{@calc.received}<br>"
    erb :error
  else
    puts "###Quantity ordered: #{params[:quantity]} Cost: #{@cost} Received: #{@calc.received}"
    @product.update_attributes!(
      quantity: @product.quantity - params[:quantity].to_i,
      sold: @product.sold + params[:quantity].to_i
    )
    erb :success
  end  
end