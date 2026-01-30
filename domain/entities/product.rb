class Product
  attr_reader :id, :name, :description, :price, :stock

  def initialize(id:, name:, description:, price:, stock:)
    @id = id
    @name = name
    @description = description
    @price = price
    @stock = stock
  end

  def available?
    stock > 0
  end

  def decrease_stock!(quantity)
    raise 'Insufficient stock' if quantity > stock
    @stock -= quantity
  end
end
