class ProductRepositoryAR
  def all
    ProductRecord.all.map { |r| to_domain(r) }
  end

  def find(id)
    record = ProductRecord.find_by(id: id)
    return nil unless record

    to_domain(record)
  end

  def save(product)
    record = ProductRecord.find(product.id)
    record.update!(
      stock: product.stock
    )
  end

  private

  def to_domain(record)
    Product.new(
      id: record.id,
      name: record.name,
      description: record.description,
      price: record.price,
      stock: record.stock
    )
  end
end

