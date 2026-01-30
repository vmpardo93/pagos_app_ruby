require_relative 'config/environment'
require 'sinatra/main'
require 'sinatra'
require 'sinatra/activerecord'

# Esto lee la configuración de config/database.yml automáticamente
set :database_file, "config/database.yml"

set :run, false

set :bind, '0.0.0.0'
set :port, 4567

get '/' do
  'API running and DB connected'
end

get '/products/count' do
  ProductRecord.count.to_s
end

repo = ProductRepositoryAR.new

get '/products' do
  content_type :json
  repo.all.map { |p|
    {
      id: p.id,
      name: p.name,
      description: p.description,
      price: p.price,
      stock: p.stock
    }
  }.to_json
end

post '/payments' do
  content_type :json

  request.body.rewind
  body = request.body.read
  data = JSON.parse(body, symbolize_names: true)

  use_case = ProcessPayment.new(
    product_repository: ProductRepositoryAR.new,
    transaction_repository: TransactionRepositoryAR.new,
    payment_service: PaymentService.new
  )

  transaction = use_case.call(
    product_id: data[:product_id],
    quantity: data[:quantity],
    card_token: data[:card_token]
  )

  {
    transaction_number: transaction.transaction_number,
    status: transaction.status
  }.to_json
end



get '/debug/products' do
  ProductRecord.all.map { |p| [p.id, p.name] }.to_json
end



Sinatra::Application.run!

run! if __FILE__ == $PROGRAM_NAME